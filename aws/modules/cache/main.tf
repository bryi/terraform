resource "aws_elasticache_subnet_group" "subnet" {
  name       = "tf-test-cache-subnet"
  subnet_ids = [var.subnet_groups]
}

resource "aws_elasticache_cluster" "cache" {
  cluster_id           = var.cluster_id
  engine               = var.engine_type
  node_type            = var.cache_node_type
  num_cache_nodes      = var.cache_node_number
  parameter_group_name = var.parameter_group
  engine_version       = var.engine_version
  port                 = var.cache_port
  subnet_group_name    = aws_elasticache_subnet_group.subnet.name
  security_group_ids   = var.security_group_ids
}