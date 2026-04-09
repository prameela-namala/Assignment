module "vpc" {

  source = "git::https://github.com/prameela-namala/aws-vpc.git?ref=main" 
  #source = "../../aws-vpc"
  vpc_cidr = var.vpc_cidr
  project_name = var.project_name
  environment = var.environment
  common_tags = var.common_tags
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  database_subnet_cidr = var.database_subnet_cidr
  is_peering_required = var.is_peering_required
}