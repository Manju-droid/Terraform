provider "aws" {
  region = "us-east-1"
  access_key = "xxxxx"
  secret_key = "xxxxx"
}

resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidrblock
  enable_dns_hostnames = var.vpc_Dns_Hostnames
  enable_dns_support = var.vpc_Dns_support
  tags = {
    Name="my-vpc"
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.subnet_cidrblock
  availability_zone       = var.subnet_avaibilityzone
  map_public_ip_on_launch = var.subnet_mappubliciponlaunch
  tags = {
    Name="subnet-1"
  }
}

resource "aws_dynamodb_table" "terraform-lock" {
    name           = "terraform_state"
    read_capacity  = 5
    write_capacity = 5
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
    tags = {
        "Name" = "DynamoDB Terraform State Lock Table"
    }
}

terraform {
  backend "s3" {
    encrypt = true
    dynamodb_table = "terraform_state"
    bucket = "mymanjunadhabucket"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}