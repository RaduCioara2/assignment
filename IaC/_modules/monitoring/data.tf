data "aws_availability_zones" "available" {}

data "aws_instance" "instances" {
  count = var.number_of_instances # number of instances deployed in the ec2 part
  filter {
    name   = "tag:Name"
    values = ["${var.instance_name_prefix}-${data.aws_availability_zones.available.names[count.index]}"]
  }
}

