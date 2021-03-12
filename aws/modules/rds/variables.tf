variable "db_identifier" {
  default = "test_db"
}

variable "engine_type" {
  default = "postgres"
}

variable "engine_version" {
  default = "11.6"
}

variable "db_name" {
  default = "test"
}

variable "username" {
  default = "admin"
}

variable "db_password" {
  default = "cool_password"
}

variable "subnet_ids" {
  default = ["subnet-0182666f6d7486503", "subnet-0d1da59908c64b180"]
}

variable "security_groups" {
  default = ["some_sg_id"]
}