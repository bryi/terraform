provider "aws" {
  region = var.region
}

#====================================================================

terraform {
  backend "s3" {
    bucket = "tfbucketstatebryi" // Bucket where to SAVE Terraform State
    key    = "prod/webservers/terraform.tfstate"             // Object name in the bucket to SAVE Terraform State
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

#--------------------------------------------------------------

module "asg_instance" {
  source = "../../modules/asg_instance"
  instance_type = "t2.micro"
  key_name = "saz-key"
  security_groups_id = data.terraform_remote_state.security_groups.outputs.SERVERS_SG_ID
  user_data = file("./user_data.sh")
  min_size = 1
  max_size = 2
  subnets_id = [data.terraform_remote_state.network.outputs.prod_private_subnet_ids[0], data.terraform_remote_state.network.outputs.prod_private_subnet_ids[1]]
}