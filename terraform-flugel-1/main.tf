provider "aws" {
  region = var.region
}
terraform {
  required_version = ">= 0.12.26"
}


resource "aws_instance" "instance_name" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = var.tags
}

resource "aws_s3_bucket" "bucket_name" {
  bucket = var.bucket_name
  acl    = "private"
  tags = var.tags
  force_destroy = true
}


# ---------------------------------------------------------------------------------------------------------------------
# LOOK UP THE LATEST UBUNTU AMI
# ---------------------------------------------------------------------------------------------------------------------

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "image-type"
    values = ["machine"]
  }

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }
}

