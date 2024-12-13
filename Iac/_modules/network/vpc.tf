module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.16.0"

  name = "eib-${var.environment}"
  cidr =  var.vpc_cidr_block

  azs              = var.aws_availability_zones
  private_subnets  = var.eib_private_subnets
  public_subnets   = var.eib_public_subnets

  enable_nat_gateway = true

  enable_dns_hostnames = true

  enable_flow_log                                 = var.enable_flow_log
  create_flow_log_cloudwatch_log_group            = true
  create_flow_log_cloudwatch_iam_role             = true
  flow_log_max_aggregation_interval               = 60
  flow_log_cloudwatch_log_group_retention_in_days = 90

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Name        = "eib-${var.environment}" 
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "eib-${var.environment}-igw"
  }
}

resource "aws_route53_zone" "private" {
  name = "${var.environment}.eib"

  vpc {
    vpc_id = module.vpc.vpc_id
  }
}
