data "aws_vpc" "current" {
  filter {
    name   = "tag:Name"
    values = ["eib-${var.environment}"]
  }
}

data "aws_availability_zones" "available" {}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.current.id]
  }

  tags = {
    Tier = "Public"
  }
}

data "aws_instance" "instances" {
  count = var.number_of_instances # number of instances deployed in the ec2 part
  filter {
    name   = "tag:Name"
    values = ["${var.instance_name_prefix}-${data.aws_availability_zones.available.names[count.index]}"]
  }
}

locals {
  webapp_host_headers = ["${var.instance_name_prefix}.${var.environment}.eib.com"]
}
