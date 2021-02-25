provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_webserver" {
  ami                    = "ami-0915bcb5fa77e4892"
  instance_type          = "t2.micro"
  key_name               = "saz-key"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data              = templatefile("./scripts/user-data.sh.tpl",{
    f_name = "Denis",
    l_name = "Astahov",
    names  = ["Vasya", "Kolya", "Petya", "John", "Donald", "Masha"]
  })
  

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Denis Astahov"
  }
}


resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web Server SecurityGroup"
    Owner = "Denis Astahov"
  }
}