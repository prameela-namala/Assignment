

# ----------------------------
# ECR
# ----------------------------
resource "aws_ecr_repository" "app_repo" {
  name                 = "webapp-dev"
  image_tag_mutability = "MUTABLE"
}

# ----------------------------
# CLOUDWATCH LOGS
# ----------------------------
resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/webapp-dev"
  retention_in_days = 7
}

# ----------------------------
# IAM ROLE
# ----------------------------
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole-dev"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ----------------------------
# ECS CLUSTER
# ----------------------------
resource "aws_ecs_cluster" "cluster" {
  name = "ecs-cluster-dev"
}

# ----------------------------
# SECURITY GROUP (TASK)
# ----------------------------
resource "aws_security_group" "task_sg" {
  name   = "task-sg-dev"
  vpc_id = data.aws_ssm_parameter.vpc_id.value

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# ----------------------------
# SECURITY GROUP (ALB)
# ----------------------------
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg-dev"
  description = "Allow HTTP inbound traffic"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # public access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# ----------------------------
# ALB
# ----------------------------
resource "aws_lb" "alb" {
  name               = "alb-dev"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]

  subnets = split(",", data.aws_ssm_parameter.public_subnet_ids.value)
}

# ----------------------------
# TARGET GROUP
# ----------------------------
resource "aws_lb_target_group" "tg" {
  name        = "tg-dev"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value
  target_type = "ip"

  health_check {
    path = "/"
    matcher = "200-399"
  }
}

# ----------------------------
# LISTENER
# ----------------------------
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

# ----------------------------
# TASK DEFINITION
# ----------------------------
resource "aws_ecs_task_definition" "task" {
  family                   = "webapp-task-dev"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "webapp"
      image     = "${aws_ecr_repository.app_repo.repository_url}:latest"
      essential = true

      portMappings = [{
        containerPort = 80
        protocol      = "tcp"
      }]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_log_group.name
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

# ----------------------------
# ECS SERVICE
# ----------------------------
resource "aws_ecs_service" "service" {
  name            = "webapp-service-dev"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = split(",", data.aws_ssm_parameter.public_subnet_ids.value)
    security_groups = [aws_security_group.task_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tg.arn
    container_name   = "webapp"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.listener]
}