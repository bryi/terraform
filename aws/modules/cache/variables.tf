variable "cluster_id" {
  default = "test-cache"
}

variable "cache_node_type" {
  default = "cache.t2.micro"
}

variable "cache_port" {
  default = 6379
}

variable "subnet_groups" {
  default = ["some_group"]
}

variable "security_group_ids" {
  default = ["sg_id"]
}

variable "cache_node_number" {
  default = "1"
}

variable "parameter_group" {
  default = "default.redis3.2"
}

variable "engine_type" {
  default = "redis"
}

variable "engine_version" {
  default = "3.2.10"
}