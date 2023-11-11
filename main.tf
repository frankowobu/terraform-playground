provider "aws" {}

variable "cidr_block_info" {
  description = "information about cidr block for vpc and subnet"
  type = list(object({
    cidr_block = string
    name = string
    az= string
  }))
}

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block_info[0].cidr_block
  tags = {
    Name = var.cidr_block_info[0].name
  }
}

resource "aws_subnet" "subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.cidr_block_info[1].cidr_block
  availability_zone = var.cidr_block_info[1].az
  tags = {
    Name = var.cidr_block_info[1].name
  }
}

data "aws_vpc" "existing_vpc" {
  cidr_block = var.cidr_block_info[0].cidr_block
}

resource "aws_subnet" "subnet2" {
  vpc_id = data.aws_vpc.existing_vpc.id
  cidr_block = var.cidr_block_info[2].cidr_block
  availability_zone = var.cidr_block_info[2].az
  tags = {
    Name = var.cidr_block_info[2].name
  }
}
