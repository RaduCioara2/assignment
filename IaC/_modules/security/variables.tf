variable "environment" {
  type = string
}

variable "instance_name_prefix" {
  description = "Prefix for the EC2 instance names"
  type        = string
}

variable "shield_advanced" {
  type        = bool
  description = "Enable Shield Advanced if needed (requires subscription)"
}