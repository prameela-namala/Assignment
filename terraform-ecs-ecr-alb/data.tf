##############################################
# Data Sources
##############################################

# Get current AWS account details
data "aws_caller_identity" "current" {}

# Get default VPC info (optional)
# data "aws_vpc" "default" {
#   default = true
# }

# Get region details
data "aws_region" "current" {}


data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
}


data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"
}

data "aws_ssm_parameter" "alb_sg_id" {
  name = "/${var.project_name}/${var.environment}/alb_sg_id"
}

data "aws_ssm_parameter" "app_sg_id" {
  name = "/${var.project_name}/${var.environment}/app_sg_id"
}