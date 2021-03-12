provider "aws" {
  region = var.region
}

#====================================================================

terraform {
  backend "s3" {
    bucket = "tfbucketstatebryi" // Bucket where to SAVE Terraform State
    key    = "prod/db/terraform.tfstate"             // Object name in the bucket to SAVE Terraform State
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

resource "random_string" "rds_password" {
  length           = 12
  special          = true
  override_special = "!#$&"

  keepers = {
    kepeer1 = var.name
    //keperr2 = var.something
  }
}

// Store Password in SSM Parameter Store
resource "aws_ssm_parameter" "rds_password" {
  name        = "/prod/postgresql"
  description = "Master Password for RDS MySQL"
  type        = "SecureString"
  value       = random_string.rds_password.result
}

// Get Password from SSM Parameter Store
data "aws_ssm_parameter" "my_rds_password" {
  name       = "/prod/postgresql"
  depends_on = [aws_ssm_parameter.rds_password]
}

module "db_instance" {
    source = "../../modules/rds"
    subnet_ids = [
        data.terraform_remote_state.network.outputs.prod_db_subnet_ids[0], 
        data.terraform_remote_state.network.outputs.prod_db_subnet_ids[1]
    ]
    db_identifier = "proddb"
    engine_type = "postgres"
    engine_version = "11.6"
    db_name = "test"
    username = "bryi"
    db_password = data.aws_ssm_parameter.my_rds_password.value
    security_groups = [
        data.terraform_remote_state.security_groups.outputs.SERVERS_DB_SG_ID
    ]

}