variable "environment" {
  type = string
}

variable "instance_type" {
    type = string
}

variable "az_list" {
    description = "list of availability zones to deploy ec2"
    type        = list(string)
    default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "num_availability_zones" {
  description = "The number of Availability Zones where EC2 instances should be launched"
  type        = number
  default     = 1
}

variable "instance_name_prefix" {
  description = "Prefix for the EC2 instance names"
  type        = string
  default     = "webapp"
}