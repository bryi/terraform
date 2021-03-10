variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "saz-key"
}

variable "security_groups_id" {
  default = "sg-0844fc99f15cdd20f"
}

variable "subnets_id" {
  default = ["subnet-0182666f6d7486503", "subnet-0d1da59908c64b180"]
}

variable "min_size" {
  default = 1
}

variable "max_size" {
  default = 2
}

variable "user_data" {
  default = "some text script"
}