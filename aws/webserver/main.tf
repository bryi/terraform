provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {}
data "aws_vpc" "my_vpc" {}
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

#--------------------------------------------------------------
resource "aws_security_group" "web2" {
  name = "Dynamic Security Group"

  dynamic "ingress" {
    for_each = ["80", "443", "22"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Dynamic SecurityGroup 2"
    Owner = "Alexey Bryi"
  }
}

resource "aws_launch_configuration" "web" {
  //  name            = "WebServer-Highly-Available-LC"
  name_prefix     = "WebServer-Highly-Available-LC-"
  image_id        = data.aws_ami.latest_amazon_linux.id
  instance_type   = "t2.micro"
  key_name        = "saz-key"
  security_groups = [aws_security_group.web2.id]
  user_data       = file("./user_data.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web" {
  name                 = "ASG-${aws_launch_configuration.web.name}"
  launch_configuration = aws_launch_configuration.web.name
  min_size             = 2
  max_size             = 2
  min_elb_capacity     = 2
  health_check_type   = "ELB"
  vpc_zone_identifier = [aws_subnet.prod_subnet_1.id, aws_subnet.prod_subnet_2.id]
  load_balancers      = [aws_elb.web.name]

  dynamic "tag" {
    for_each = {
      Name   = "WebServer in ASG"
      Owner  = "Alexey Bryi"
      TAGKEY = "TAGVALUE"
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elb" "web" {
  name               = "WebServer-HA-ELB"
  availability_zones = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  security_groups    = [aws_security_group.web2.id]
  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = 80
    instance_protocol = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 5
  }
  tags = {
    Name = "WebServer-Highly-Available-ELB"
  }
}

resource "aws_subnet" "prod_subnet_1" {
  vpc_id            = data.aws_vpc.my_vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = "172.31.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet-1 in ${data.aws_availability_zones.available.names[0]}"
  }
}

resource "aws_subnet" "prod_subnet_2" {
  vpc_id            = data.aws_vpc.my_vpc.id
  availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block        = "172.31.2.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet-2 in ${data.aws_availability_zones.available.names[1]}"
  }
}
#--------------------------------------------------
output "web_loadbalancer_url" {
  value = aws_elb.web.dns_name
}