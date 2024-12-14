resource "aws_security_group" "instance_sg" {
  name   = "${var.instance_name_prefix}-sg-INT"
  vpc_id = data.aws_vpc.current

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "webapp" {
  count = var.num_availability_zones # Launch instances in the specified number of AZs

  ami               = data.aws_ami.amzn-linux-2023-ami
  instance_type     = var.instance_type
  availability_zone = data.aws_availability_zones.available.names[count.index] # Dynamically use AZs
  subnet_id         = data.aws_subnets.private.ids[count.index]                # Subnet ID from the filtered subnets list
  security_groups   = aws_security_group.instance_sg.id

  credit_specification {
    cpu_credits = "unlimited"
  }

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Name        = "${var.instance_name_prefix}-${data.aws_availability_zones.available.names[count.index]}"
  }
}

resource "aws_route53_record" "webinstance" {
  count = var.num_availability_zones

  zone_id = data.aws_route53_zone.this
  type    = "A"
  ttl     = "300"
  name    = "${var.instance_name_prefix}-${data.aws_availability_zones.available.names[count.index]}.development.eib.com"
  records = [aws_instance.webapp[count.index].private_ip]

  depends_on = [aws_instance.webapp]
}