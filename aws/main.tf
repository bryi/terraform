provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "my-test-1" {
  count = 1
  ami           = "ami-0915bcb5fa77e4892"
  instance_type = "t2.micro"

  tags = {
    Name    = "My first"
    Project = "Terraform Lessons"
  }
}