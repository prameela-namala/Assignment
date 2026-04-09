module "app_sg_id" {
    source = "git::https://github.com/prameela-namala/terraform-aws-securitygroup.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "app_sg"
    vpc_id = local.vpc_id
    # common_tags = var.common_tags
    sg_tags = var.app_sg_id_tags
}

module "alb_sg_id" {
    source = "git::https://github.com/prameela-namala/terraform-aws-securitygroup.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "alb_sg"
    vpc_id = local.vpc_id
    # common_tags = var.common_tags
    sg_tags = var.alb_sg_id_tags
}




#mysql allowing connctions on 3306 from the instances attached to backend
# resource "aws_security_group_rule" "app_sg" {
#   type              = "ingress"
#   from_port         = 3306
#   to_port           = 3306
#   protocol          = "tcp"
#   source_security_group_id = module.backend_sg.id
#   security_group_id = module.mysql_sg.id
# }

# #backend allowing connctions on 8080 from the instances attached to frontend
# resource "aws_security_group_rule" "backend" {
#   type              = "ingress"
#   from_port         = 8080
#   to_port           = 8080
#   protocol          = "tcp"
#   source_security_group_id = module.frontend_sg.id
#   security_group_id = module.backend_sg.id
# }


# resource "aws_security_group_rule" "frontend_public" {
#   type              = "ingress"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   cidr_blocks = [ "0.0.0.0/0" ]
#   security_group_id = module.frontend_sg.id
# }

# resource "aws_security_group_rule" "mysql_bastion" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   source_security_group_id = module.bastion_sg.id
#   security_group_id = module.mysql_sg.id
# }
# resource "aws_security_group_rule" "backend_bastion" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   source_security_group_id = module.bastion_sg.id
#   security_group_id = module.backend_sg.id
# }
# resource "aws_security_group_rule" "frontend_bastion" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   source_security_group_id = module.bastion_sg.id
#   security_group_id = module.frontend_sg.id
# }

# resource "aws_security_group_rule" "mysql_ansible" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   source_security_group_id = module.ansible_sg.id
#   security_group_id = module.mysql_sg.id
# }
# resource "aws_security_group_rule" "backend_ansible" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   source_security_group_id = module.ansible_sg.id
#   security_group_id = module.backend_sg.id
# }
# resource "aws_security_group_rule" "frontend_ansible" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   source_security_group_id = module.ansible_sg.id
#   security_group_id = module.frontend_sg.id
# }
# resource "aws_security_group_rule" "ansible_public" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]
#   security_group_id = module.ansible_sg.id
# }

# resource "aws_security_group_rule" "bastion_public" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]
#   security_group_id = module.bastion_sg.id
# }