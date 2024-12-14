variable "environment" {
  type = string
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "aws_availability_zones" {
  type    = list(string)
  default = []
}

variable "eib_private_subnets" {
  type    = list(string)
  default = []
}

variable "eib_public_subnets" {
  type    = list(string)
  default = []
}

variable "enable_flow_log" {
  type    = bool
  default = false
}

