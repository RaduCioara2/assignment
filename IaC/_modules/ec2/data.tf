data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

data "aws_availability_zones" "available" {}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.current.id]
  }

  tags = {
    Tier = "Private"
  }
}


data "aws_vpc" "current" {
  filter {
    name   = "tag:Name"
    values = ["eib-${var.environment}"]
  }
}

data "aws_route53_zone" "this" {
  name         = "${var.environment}.eib"
  private_zone = true
}