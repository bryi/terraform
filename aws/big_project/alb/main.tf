provider "aws" {
  region = var.region
}

#====================================================================

terraform {
  backend "s3" {
    bucket = "tfbucketstatebryi" // Bucket where to SAVE Terraform State
    key    = "prod/alb/terraform.tfstate"             // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                                 // Region where bycket created
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "tfbucketstatebryi" // Bucket from where to GET Terraform State
    key    = "prod/network/terraform.tfstate"             // Object name in the bucket to GET Terraform state
    region = "us-east-1"                                 // Region where bycket created
  }
}

data "terraform_remote_state" "security_groups" {
  backend = "s3"
  config = {
    bucket = "tfbucketstatebryi" // Bucket from where to GET Terraform State
    key    = "prod/security_groups/terraform.tfstate"             // Object name in the bucket to GET Terraform state
    region = "us-east-1"                                 // Region where bycket created
  }
}

data "terraform_remote_state" "webservers" {
  backend = "s3"
  config = {
    bucket = "tfbucketstatebryi" // Bucket from where to GET Terraform State
    key    = "prod/webservers/terraform.tfstate"             // Object name in the bucket to GET Terraform state
    region = "us-east-1"                                 // Region where bycket created
  }
}

data "aws_acm_certificate" "domain" {
  domain = var.domain_name
}

module "alb" {
    source = "../../modules/alb"
    vpc_id = data.terraform_remote_state.network.outputs.vpc_id
    certificate_arn = data.aws_acm_certificate.domain.arn
    security_groups_id = [
        data.terraform_remote_state.security_groups.outputs.ELB_SG_ID,
        data.terraform_remote_state.security_groups.outputs.ELB_SERVERS_SG_ID
        ]
    subnet_ids = [data.terraform_remote_state.network.outputs.prod_public_subnet_ids[0], data.terraform_remote_state.network.outputs.prod_public_subnet_ids[1]]
    enable_cross_zone_lb = false
    enable_stickiness = false
    autoscaling_group_name = data.terraform_remote_state.webservers.outputs.asg_name  
}