provider "aws" {
    access_key = "AKIATUJLS22QWWJAFGUB"
    secret_key = "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"
    region = "us-east-1"
}

resource "aws_instance" "my-test-1" {
  ami           = "ami-0915bcb5fa77e4892"
  instance_type = "t2.micro"

  tags = {
    Name    = "My first"
    Project = "Terraform Lessons"
  }
}

resource "aws_instance" "my_Amazon" {
  ami           = "ami-0915bcb5fa77e4892"
  instance_type = "t2.micro"

  tags = {
    Name    = "My Amazon Server"
    Owner   = "Denis Astahov"
    Project = "Terraform Lessons"
  }
}