provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "tfbucketstatebryi" // Bucket where to SAVE Terraform State
    key    = "prod/network/terraform.tfstate"             // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                                 // Region where bycket created
  }
}

module "vpc-prod" {
  source = "../../modules/aws_network"
  // source               = "git@github.com:adv4000/terraform-modules.git//aws_network"
  env                  = "prod"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  db_subnet_cidrs = ["10.0.5.0/24", "10.0.6.0/24"]
}


#===============================================
