provider "aws" {
  region = "us-east-1"
}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_webserver.id
  tags = {
    Name  = "Web Server IP"
    Owner = "Alexey Bryi"
  }
}


resource "aws_instance" "my_webserver" {
  ami                    = "ami-0915bcb5fa77e4892"
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
