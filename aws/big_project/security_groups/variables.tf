variable "region" {
  description = "AWS Region where to provision VPC Network"
  default     = "us-east-1"
}

variable "port_list" {
  default = ["22", "80", "443"]
}

variable "resource_name" {
  default = "webserver"
}

variable "cidr_blocks" {
  default = "0.0.0.0/0"
}