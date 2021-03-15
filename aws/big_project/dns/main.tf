provider "aws" {
  region = var.region
}

#====================================================================

terraform {
  backend "s3" {
    bucket = "DEFAULT_NAME" // Bucket where to SAVE Terraform State
    key    = "prod/dns/terraform.tfstate"             // Object name in the bucket to SAVE Terraform State
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

module "dns" {
    source = "../../modules/dns_zone"
    domain_name = "bryidomain.tk"
    alb_dns_name = data.terraform_remote_state.alb.outputs.alb_dns_name
    alb_zone_id = data.terraform_remote_state.alb.outputs.alb_zone_id
    
}