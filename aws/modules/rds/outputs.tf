output "db_endpoint" {
  value = aws_db_instance.default.endpoint
}

output "db_endpoint_port" {
  value = aws_db_instance.default.port
}