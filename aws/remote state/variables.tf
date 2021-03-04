variable "region" {
  description = "Please Enter AWS Region to deploy Server"
  type        = string
  default     = "us-east-1"
}

variable "s3_bucket_name" {
  type    = string
  default = "tfremotestatebucketbryi"
}

variable "env" {
  type    = string
  default = "dev"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
  ]
}

variable "instance_type" {
  default = "t2.micro"
}