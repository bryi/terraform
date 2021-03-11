provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "b" {
  bucket = var.s3_bucket_name
  acl    = "private"

  tags = {
    Name        = var.s3_bucket_name
    Environment = var.env
  }
}