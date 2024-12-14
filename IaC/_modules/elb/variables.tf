variable "environment" {
  type = string
}

variable "number_of_instances" {
  description = "Number of EC2 instances launched for the webapp"
  type        = number
}

variable "instance_name_prefix" {
  description = "Prefix for the EC2 instance names"
  type        = string
}

variable "ext_alb_idle_timeout_sec" {
  description = "Timeout for requests to the external ALB"
  type        = number
}

variable "bucket_name" {
  description = "name of access logs bucket"
  type        = string
}

variable "ext_alb_ssl_policy" {
  description = "External ELB SSL Policy"
  type        = string
}

variable "webapp_blue_cookie_duration" {
  description = "Sticky sessions duration for webapp_blue"
  type        = number
}

variable "webapp_blue_alb_healthcheck_interval" {
  description = "The approximate amount of time, in seconds, between health checks of an individual target."
  type        = number
}

variable "webapp_blue_alb_healthcheck_timeout" {
  description = "The amount of time, in seconds, during which no response from a target means a failed health check."
  type        = number
}

variable "webapp_blue_alb_healthcheck_matcher" {
  description = "The HTTP codes to use when checking for a successful response from a target. "
  type        = number
}

variable "webapp_blue_alb_healthy_threshold" {
  description = "The number of consecutive successful health checks required before considering an unhealthy target healthy. "
  type        = number
}

variable "webapp_blue_alb_unhealthy_threshold" {
  description = "The number of consecutive failed health checks required before considering a target unhealthy."
  type        = number
}

variable "webapp_blue_alb_healthcheck_path" {
  description = "The ping path that is the destination on the targets for health checks."
  type        = string
}
#######################################
#WAF
#######################################

variable "waf_blocked_addresses" {
  description = "IP set that will be bocked"
  type        = list(string)
}
#######################################
# blocked fixed message
#######################################

variable "alb_blocked_content_type" {
  description = "Content type for requests that are blocked for sensitive paths"
  type        = string
  default     = "text/html"
}

variable "alb_blocked_message_body" {
  description = "Message body to display for requests that are blocked for sensitive paths"
  type        = string
  default     = "<!DOCTYPE html><html><head><title>EIB</title><meta charset=\"utf-8\"/></head><body>Page not found.</body></html>"
}

variable "alb_blocked_status_code" {
  description = "http response code to return for requests that are blocked for sensitive paths"
  type        = string
  default     = "404"
}