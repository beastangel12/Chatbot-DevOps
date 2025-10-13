terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  # Provider will use credentials from your AWS CLI (~/.aws/credentials) or environment variables.
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_key_pair" "devops_key" {
  key_name   = "devops-key"
  public_key = file(var.public_key_path)
}

resource "aws_security_group" "devops_sg" {
  name        = "devops-sg"
  description = "Allow SSH, HTTP, Kubernetes ports"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "master" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.devops_key.key_name
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  associate_public_ip_address = true
  tags = { Name = "master-node" }
}

resource "aws_instance" "worker" {
  count = 2
  ami   = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.devops_key.key_name
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  associate_public_ip_address = true
  tags = { Name = "worker-${count.index}" }
}
