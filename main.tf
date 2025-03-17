provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "my-vpc"{
      cidr_block = "10.1.0.0/16"
      enable_dns_hostnames = true
      enable_dns_support = true
}

resource "aws_subnet" "subnet-1" {
      vpc_id = aws_vpc.my-vpc.id
      cidr_block = "10.1.1.0/24"
      availability_zone = "us-east-1a"
      enable_dns64 = true
      map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "my-igw" {
      vpc_id = aws_vpc.my-vpc.id
}

resource "aws_route_table" "my-route" {
      vpc_id = aws_vpc.my-vpc.id

      route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my-igw.id
      }
}

resource "aws_route_table_association" "subnet association" {
    subnet_id = aws_subnet.subnet-1.id
    route_table_id = aws_route_table.my-route.id
}

resource "aws_security_group" "my-security" {
      vpc_id = aws_vpc.my-vpc.id
      
      ingress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = "[0.0.0.0/0]"
      }
      egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = "[0.0.0.0/0]"
      }
}

resource "aws_key_pair" "LaptopKey" {
       public_key = file("~/.ssh/id_rsa.pub")
       key_name = "LaptopKey"
}
