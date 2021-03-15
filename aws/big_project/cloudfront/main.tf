provider "aws" {
  region = var.region
}

#====================================================================

terraform {
  backend "s3" {
    bucket = "DEFAULT_NAME" // Bucket where to SAVE Terraform State
    key    = "prod/cloudfront/terraform.tfstate"             // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                                 // Region where bycket created
  }
}

data "terraform_remote_state" "alb" {
  backend = "s3"
  config = {
    bucket = "DEFAULT_NAME" // Bucket from where to GET Terraform State
    key    = "prod/alb/terraform.tfstate"             // Object name in the bucket to GET Terraform state
    region = "us-east-1"                                 // Region where bycket created
  }
}

data "aws_acm_certificate" "domain" {
  domain = var.domain_name
}

module "cloudfront" {
    source = "../../modules/cloudfront"
    dependency_arn = data.terraform_remote_state.alb.outputs.alb_id
    alias_domain = ["bryidomain.tk"]
    target_id = data.terraform_remote_state.alb.outputs.alb_id
    target_domain_name = data.terraform_remote_state.alb.outputs.alb_dns_name
    certificate_arn = data.aws_acm_certificate.domain.arn
}
