resource "aws_shield_protection" "alb_protection" {
  name         = "${var.instance_name_prefix}-${var.environment}-protection"
  resource_arn = data.aws_lb.alb.arn
}

resource "aws_shield_subscription" "alb_protection" {
  count      = var.shield_advanced ? 1 : 0 # Create this resource only if shield_advanced is true 
  auto_renew = "ENABLED"
}