variable "instance_name_prefix" {
  description = "Prefix for the EC2 instance names"
  type        = string
  default     = "webapp"
}

variable "number_of_instances" {
  description = "Number of instances deployed in the ec2 part"
  type        = number
}
