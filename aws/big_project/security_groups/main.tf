provider "aws" {
  region = var.region
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "tfbucketstatebryi" // Bucket from where to GET Terraform State
    key    = "prod/network/terraform.tfstate"             // Object name in the bucket to GET Terraform state
    region = "us-east-1"                                 // Region where bycket created
  }
}

terraform {
  backend "s3" {
    bucket = "tfbucketstatebryi" // Bucket where to SAVE Terraform State
    key    = "prod/security_groups/terraform.tfstate"             // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                                 // Region where bycket created
  }
}

module "security_group_elb" {
  source = "../../modules/aws_security_group"
  port_list = ["80", "443"]
  resource_name = "ELB-SG"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
}

module "security_group_elb_server" {
  source = "../../modules/aws_security_group"
  port_list = ["80", "443"]
  resource_name = "ELB-SERVERS"
  cidr_blocks = "10.0.0.0/16"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
}

module "security_group_servers" {
  source = "../../modules/aws_security_group"
  port_list = ["22", "80", "443"]
  resource_name = "SERVERS"
  cidr_blocks = "10.0.0.0/16"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
}

module "security_group_bastion" {
  source = "../../modules/aws_security_group"
  port_list = ["22"]
  resource_name = "BASTION-SG"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
}

module "security_group_servers_db" {
  source = "../../modules/aws_security_group"
  port_list = ["0"]
  resource_name = "SERVERS-DB"
  cidr_blocks = "10.0.0.0/16"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
}


#===============================================
