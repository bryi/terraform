provider "aws" {
  region = var.region
}

#====================================================================

terraform {
  backend "s3" {
    bucket = "DEFAULT_NAME" // Bucket where to SAVE Terraform State
    key    = "prod/cache/terraform.tfstate"             // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                                 // Region where bycket created
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "DEFAULT_NAME" // Bucket from where to GET Terraform State
    key    = "prod/network/terraform.tfstate"             // Object name in the bucket to GET Terraform state
    region = "us-east-1"                                 // Region where bycket created
  }
}

data "terraform_remote_state" "security_groups" {
  backend = "s3"
  config = {
    bucket = "DEFAULT_NAME" // Bucket from where to GET Terraform State
    key    = "prod/security_groups/terraform.tfstate"             // Object name in the bucket to GET Terraform state
    region = "us-east-1"                                 // Region where bycket created
  }
}

module "cache" {
    source = "../../modules/cache"
    cluster_id = "test-cluster"
    subnet_groups = data.terraform_remote_state.network.outputs.prod_db_subnet_ids[0]
    cache_node_number = 1
    security_group_ids = [
        data.terraform_remote_state.security_groups.outputs.SERVERS_CACHE_SG_ID
    ]
}