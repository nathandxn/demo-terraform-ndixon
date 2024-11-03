terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "ndixon"
    workspaces {
      name = "demo"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "instances" {
  name = "instance-security-group"
}

resource "aws_instance" "instance_1" {
  ami           = "ami-005fc0f236362e99f" # Ubuntu 20.04 LTS // us-east-1
  instance_type = "t2.micro"
  security_groups = [aws_security_group.instances.name]
  user_data       = <<-EOF
              #!/bin/bash
              echo "Hello, World 1" > index.html
              python3 -m http.server 8080 &
              EOF
}

resource "aws_instance" "instance_2" {
  ami             = "ami-005fc0f236362e99f" # Ubuntu 20.04 LTS // us-east-1
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.instances.name]
  user_data       = <<-EOF
              #!/bin/bash
              echo "Hello, World 2" > index.html
              python3 -m http.server 8080 &
              EOF
}