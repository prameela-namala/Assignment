##############################################
# Locals
##############################################

locals {
  environment = var.environment
  env_suffix  = lower(var.environment)

  common_tags = {
    Project     = "ECS-Fargate-ALB"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}