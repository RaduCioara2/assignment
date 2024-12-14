resource "aws_wafv2_ip_set" "albDenyIPSet" {
  name               = "${var.instance_name_prefix}-${var.environment}-alb-denyIPSet"
  description        = "ALB Deny IP Set"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = var.waf_blocked_addresses

  tags = {
    Name = "${var.instance_name_prefix}-${var.environment}-alb-denyIPSet"
  }
}


resource "aws_wafv2_web_acl" "webapp_waf" {
  name  = "${var.instance_name_prefix}-${var.environment}-waf"
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "AWSRateBasedRuleDOS"
    priority = 1

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 1000
        aggregate_key_type = "IP"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSRateBasedRuleDOS"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSIPBlackList"
    priority = 2

    action {
      block {}
    }

    statement {
      or_statement {
        statement {
          ip_set_reference_statement {
            arn = aws_wafv2_ip_set.albDenyIPSet.arn
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSIPBlackList"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 10

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesCommonRuleSetMetric"
      sampled_requests_enabled   = true
    }
  }


  rule {
    name     = "AWSManagedRulesKnownBadInputsRuleSet"
    priority = 20

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesKnownBadInputsRuleSetMetric"
      sampled_requests_enabled   = true
    }
  }


  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.instance_name_prefix}-${var.environment}-waf"
    sampled_requests_enabled   = true
  }

  tags = {
    Name = "${var.instance_name_prefix}-${var.environment}-waf"
  }
}

resource "aws_wafv2_web_acl_association" "webapp" {
  resource_arn = aws_lb.webapp.arn
  web_acl_arn  = aws_wafv2_web_acl.webapp_waf.arn
}