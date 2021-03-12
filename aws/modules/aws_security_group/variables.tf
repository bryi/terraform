variable "port_list" {
  default = ["22", "80", "443"]
}

variable "resource_name" {
  default = "webserver"
}

variable "cidr_blocks" {
  default = "0.0.0.0/0"
}

variable "vpc_id" {
  default = "vpc-03c64c92a2f1b9106"
}

variable "egress_cidr" {
  default = "0.0.0.0/0"
}