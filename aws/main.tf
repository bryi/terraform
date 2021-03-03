provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


resource "aws_instance" "my_webserver" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t2.micro"
  key_name               = "saz-key"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data = templatefile("./scripts/user-data.sh.tpl", {
    f_name = "Denis",
    l_name = "Astahov",
    names  = ["Vasya", "Kolya", "Petya", "John", "Masha"]
  })


  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Alexey Bryi"
  }
  lifecycle {
    create_before_destroy = true
  }
}

