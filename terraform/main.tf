terraform {
  backend "s3" {
    bucket = "kyrillos-terraform-state"
    key    = "todo-app/terraform/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  region = var.aws_region
}

module "todo_security_group" {
  source = "./modules/security_group"
  my_ip  = var.my_ip
}

module "todo_ec2" {
  source             = "./modules/ec2"
  instance_type      = var.instance_type
  key_name           = var.key_name
  security_group_ids = [module.todo_security_group.sg_id]
}
