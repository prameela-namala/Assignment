##############################################
# Dev Environment Variables
##############################################

region        = "us-east-1"
environment   = "dev"

# Networking
vpc_id         = data.aws_ssm_parameter.vpc_id.value
public_subnets = split(",", data.aws_ssm_parameter.public_subnet_ids.value)
#private_subnets = ["subnet-ccc333", "subnet-ddd444"]

# Security Groups
alb_sg_id = data.aws_ssm_parameter.alb_sg_id.value
app_sg_id = data.aws_ssm_parameter.app_sg_id.value

# ECS Configuration
app_cpu      = 256
app_memory   = 512
image_tag    = "latest"
desired_count = 1

# Secret (use ARN of secret in AWS Secrets Manager)

app_secret_arn = "arn:aws:secretsmanager:us-east-1:752192503692:secret:APP_SECRET-3vRpHC"


