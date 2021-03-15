variable "region" {
  description = "Please Enter AWS Region to deploy Server"
  type        = string
  default     = "us-east-1"
}

variable "s3_bucket_name" {
  type    = string
  default = "DEFAULT_NAME"
}

variable "env" {
  type    = string
  default = "dev"
}