resource "aws_db_subnet_group" "db_group" {
  name_prefix = "main-"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "default" {
  identifier           = var.db_identifier
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = var.engine_type
  engine_version       = var.engine_version
  instance_class       = "db.t2.micro"
  name                 = var.db_name
  username             = var.username
  password             = var.db_password
  skip_final_snapshot  = true
  apply_immediately    = true
  vpc_security_group_ids = var.security_groups
  db_subnet_group_name = aws_db_subnet_group.db_group.name
}

