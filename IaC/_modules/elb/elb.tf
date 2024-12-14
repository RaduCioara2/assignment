resource "aws_acm_certificate" "cert" {
  domain_name       = "${var.instance_name_prefix}.${var.environment}.eib.com"
  validation_method = "DNS"

  tags = {
    Environment = "${var.environment}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "elb_sg" {
  name   = "${var.instance_name_prefix}-elb-sg-EXT"
  vpc_id = data.aws_vpc.current

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "webapp" {
  name               = "${var.instance_name_prefix}-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = data.aws_subnets.public.ids

  ip_address_type = "ipv4"

  idle_timeout = var.ext_alb_idle_timeout_sec

  enable_deletion_protection = true

  access_logs {
    bucket  = var.bucket_name
    prefix  = "${var.instance_name_prefix}-lb"
    enabled = true
  }

  tags = {
    Environment = "${var.environment}"
  }

  depends_on = [aws_acm_certificate.cert]
}


resource "aws_alb_listener" "webapp_https" {
  load_balancer_arn = aws_lb.webapp.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ext_alb_ssl_policy
  certificate_arn   = aws_acm_certificate.cert.arn

  #
  # If rule not matched or no healthy nodes default to generic page
  #
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = var.alb_blocked_content_type
      message_body = var.alb_blocked_message_body
      status_code  = var.alb_blocked_status_code
    }
  }
}

resource "aws_alb_listener_rule" "webapp_https" {
  listener_arn = aws_alb_listener.webapp_https.arn
  priority     = 1000

  action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_alb_target_group.webapp_blue.arn
        weight = 100
      }

      stickiness {
        enabled  = true
        duration = 3600
      }
    }
  }

  condition {
    host_header {
      values = local.webapp_host_headers
    }
  }
}

resource "aws_alb_target_group" "webapp_blue" {
  name     = "${var.instance_name_prefix}-blue"
  port     = 8000
  protocol = "HTTP"

  stickiness {
    type            = "lb_cookie"
    enabled         = true
    cookie_duration = var.webapp_blue_cookie_duration
  }

  vpc_id = data.aws_vpc.current.id

  health_check {
    interval            = var.webapp_blue_alb_healthcheck_interval
    timeout             = var.webapp_blue_alb_healthcheck_timeout
    healthy_threshold   = var.webapp_blue_alb_healthy_threshold
    unhealthy_threshold = var.webapp_blue_alb_unhealthy_threshold
    matcher             = var.webapp_blue_alb_healthcheck_matcher
    path                = var.webapp_blue_alb_healthcheck_path
  }

  tags = {
    Name = "${var.instance_name_prefix}-blue"
  }
}


############################################
# webapp_blue
############################################

resource "aws_alb_target_group_attachment" "webapp_blue" {
  for_each = data.aws_instance.instances

  target_group_arn = aws_alb_target_group.webapp_blue.arn
  target_id        = data.aws_instance.instances[each.key].id
}
