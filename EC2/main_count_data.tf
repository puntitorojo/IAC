terraform {
  required_version = ">=0.12"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.13.0"
    }
  }
}

/*
resource "aws_instance" "ec2-test" {
  ami = "ami-0beafb294c86717a8"
  instance_type = "t2.micro"
  tags = {
    Name = "tf-training"
  }
}
*/

# ===============================================================
# Proposito:    crear instancia EC2 AWS con PHP 5 y Apache24
# Autor:        Heber Benitez
# Fecha:        20.07.21
# Version:      1.1
# ===============================================================


# Configure AWS Provider
provider "aws" {
  shared_credentials_file = var.aws_shared_credentials_file
  profile                 = var.aws_profile
  region                  = var.aws_region_id
}

# Setup SG configuration
resource "aws_security_group" "Permitir_desde_casa" {
  name   = var.security_group_name
  vpc_id = data.aws_vpc.default.id

  # SSH - Allow incoming connections from home to machine, over tcp port 22
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ingress_ssh_cidr_block]
  }

  # PING - Allow incoming connections from home to machine, ICMP only
  ingress {
    # from_port see -> https://github.com/hashicorp/terraform/issues/1313
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = [var.ingress_icmp_cidr_block]
  }

  # WWW - Allow incoming connections from home to machine, HTTP only
  ingress {
    from_port   = 0
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.ingress_http_cidr_block]
  }

  # ALL - Allow outgoing connections from machine to inet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.egress_cidr_block_all]
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["337001824070"] # Canonical
}

# Create ec2 instance
resource "aws_instance" "TEST-PUB" {
  ami                         = var.ami_id
  #ami = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  count                       = var.number_of_instances
  subnet_id                   = element(var.aws_subnet_id_test_pub, count.index)
  associate_public_ip_address = true
  key_name                    = var.pki_name
  vpc_security_group_ids      = [aws_security_group.Permitir_desde_casa.id]
  user_data = file("install_script.sh")

  tags = {
    Name = "PUB-WWW-UP-${count.index + 0}"
  }
}

# outputting values
output "security_group_names" {
  value = aws_security_group.Permitir_desde_casa
}
