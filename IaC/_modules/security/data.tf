data "aws_availability_zones" "available" {}
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "aws_lb" "alb" {
  name = "${var.instance_name_prefix}-${var.environment}"
}