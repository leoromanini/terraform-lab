terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "dev" {
    count = 3
    ami = "ami-0ab4d1e9cf9a1215a"
    instance_type = "t2.micro"
    key_name = "terraform-aws"
    tags = {
        Name = "dev${count.index}"
    }
    vpc_security_group_ids = ["sg-024a891964fb4a10b"]
}

resource "aws_security_group" "ssh_access" {
  name        = "ssh_access"
  description = "Allow ssh_access"

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks = ["177.94.139.214/32"]
  }

  tags = {
    Name = "allow_ssh"
  }
}