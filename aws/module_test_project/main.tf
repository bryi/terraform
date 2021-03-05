provider "aws" {
  region = var.region
}

module "vpc-prod" {
  source = "../modules/aws_network"
  // source               = "git@github.com:adv4000/terraform-modules.git//aws_network"
  env                  = "prod"
  vpc_cidr             = "10.10.0.0/16"
  public_subnet_cidrs  = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  private_subnet_cidrs = ["10.10.11.0/24", "10.10.22.0/24", "10.10.33.0/24"]
}

module "security_group" {
  source = "../modules/aws_security_group"
  // source               = "git@github.com:adv4000/terraform-modules.git//aws_network"
  port_list = ["22", "80", "443"]
  resource_name = "webserver"
}

module "security_group_elb" {
  source = "../modules/aws_security_group"
  // source               = "git@github.com:adv4000/terraform-modules.git//aws_network"
  port_list = ["80", "443"]
  resource_name = "elb"
}

#===============================================
