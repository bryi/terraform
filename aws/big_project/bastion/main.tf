provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "DEFAULT_NAME" // Bucket where to SAVE Terraform State
    key    = "prod/bastion/terraform.tfstate"             // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                                 // Region where bycket created
  }
}
#====================================================================


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

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
#===============================================================


resource "aws_instance" "bastion_instance" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [data.terraform_remote_state.security_groups.outputs.BASTION_SG_ID]
  subnet_id              = data.terraform_remote_state.network.outputs.prod_public_subnet_ids[0]
  tags = {
    Name = "Bastion_Server"
  }
}

