variable "security_groups_id" {
  default = ["sg-0844fc99f15cdd20f"]
}

variable "subnet_ids" {
  default = ["subnet-0182666f6d7486503", "subnet-0d1da59908c64b180"]
}

variable "enable_cross_zone_lb" {
  type = bool
  default = false
}

variable "domain_name" {
  default = "bryidomain.tk"
}

variable "vpc_id" {
  default = "vpc-03c64c92a2f1b9106"
}

variable "enable_stickiness" {
  type = bool
  default = false
}

variable "autoscaling_group_name" {
  default = "test"
}

variable "certificate_arn" {
  default = "some_arn"
}