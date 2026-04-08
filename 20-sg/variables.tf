variable "project_name" {

    default = "expense"
  
}

variable "environment" {

    default = "dev"
  
}

/* variable "common_tags" {
  
  default = {

    project = "expense"
    environment = "dev"
    terraform = true
  }
}
variable "mysql_sg_tags" {
    default = {

        component = "mysql"
    }
  
}

variable "backend_sg_tags" {
  
   default = {
        component = "backend"
   }
}

variable "frontent_sg-tags" {
  
   default = {
        component = "frontend"
   }
}


variable "bastion_sg-tags" {
  
   default = {
        component = "bastion"
   }
}

variable "ansible_sg_tags" {
  default = {}
} */

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}


variable "app_sg_id_tags" {
    default = {

        component = "app_sg"
    }
  
}

variable "alb_sg_id_tags" {
    default = {

        component = "alb_sg"
    }
  
}