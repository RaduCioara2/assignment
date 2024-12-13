# ELB
environment              = "development"
instance_name_prefix     = "webapp"
number_of_instances      = "2"
ext_alb_idle_timeout_sec = 60
ext_alb_ssl_policy       = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
bucket_name              = "eib-development-ELB-accesslogs"

webapp_green_cookie_duration = 86400

webapp_green_alb_healthcheck_interval = 30
webapp_green_alb_healthcheck_timeout = 10
webapp_green_alb_healthcheck_matcher = 200
webapp_green_alb_healthy_threshold = 2
webapp_green_alb_unhealthy_threshold = 2
webapp_blue_alb_healthcheck_path = "/health"


#WAF
waf_blocked_addresses = ["10.12.54.2/32", "12.8.124.2/32"]
