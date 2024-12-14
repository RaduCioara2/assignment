data "aws_vpc" "current" {
  filter {
    name   = "tag:Name"
    values = ["eib-${var.environment}"]
  }
}

data "aws_iam_role" "monitoring_role_main" {
  count = var.monitoring_interval_main > 0 ? 1 : 0

  name = var.monitoring_role_name_main
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.current.id]
  }

  tags = {
    Tier = "Private"
  }
}

data "aws_caller_identity" "current" {}

data "aws_kms_key" "by_alias" {
  key_id = "alias/${local.db_identifier}-kms" # KMS key used for encryption
}