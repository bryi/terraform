variable "port_list" {
  default = ["22", "80", "443"]
}

variable "resource_name" {
  default = "webserver"
}

variable "cidr_blocks" {
  default = "0.0.0.0/0"
}