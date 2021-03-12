resource "aws_security_group" "security_group" {
  name = "Dynamic Security Group - ${var.resource_name}"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.port_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.cidr_blocks]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.egress_cidr]
  }

  tags = {
    Name  = "Dynamic Security Group - ${var.resource_name}"
    Owner = "Alexey Bryi"
  }
}