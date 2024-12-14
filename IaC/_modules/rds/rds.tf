locals {
  db_identifier = "${var.instance_name}-${var.environment}-${var.engine_main}"
}

resource "aws_security_group" "db_instance_sg" {
  name   = "${local.db_identifier}-sg-db"
  vpc_id = data.aws_vpc.current

  ingress {
    from_port   = 5959
    to_port     = 5959
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
resource "aws_db_subnet_group" "rds_main" {
  name       = "rds_main"
  subnet_ids = [data.aws_subnets.private.ids]

  tags = {
    Name = "${var.environment}--db-subnetgroup"
  }
}

########################################################################################
# RDS instances
########################################################################################
resource "aws_db_instance" "rds_main" {

  identifier = local.db_identifier

  allocated_storage           = var.allocated_storage_main
  allow_major_version_upgrade = var.allow_major_version_upgrade_main
  apply_immediately           = var.apply_immediately_main
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade_main
  availability_zone           = var.multi_az_main ? "" : element(var.AZS, 0)
  backup_retention_period     = var.backup_retention_period_main
  backup_window               = var.backup_window_main

  blue_green_update {
    enabled = var.blue_green_update_enabled_main
  }

  db_name                               = local.db_identifier
  db_subnet_group_name                  = aws_db_subnet_group.rds_main.name
  enabled_cloudwatch_logs_exports       = var.enabled_cloudwatch_logs_exports_main
  engine                                = var.engine_main
  engine_version                        = var.engine_version_main
  iam_database_authentication_enabled   = var.iam_database_authentication_enabled_main
  instance_class                        = var.instance_class_main
  iops                                  = var.iops_main
  kms_key_id                            = data.aws_kms_key.by_alias.arn
  maintenance_window                    = var.maintenance_window_main
  max_allocated_storage                 = var.max_allocated_storage_main
  monitoring_interval                   = var.monitoring_interval_main
  monitoring_role_arn                   = var.monitoring_interval_main > 0 ? data.aws_iam_role.monitoring_role_main[0].arn : null
  multi_az                              = var.multi_az_main
  network_type                          = var.network_type_main
  option_group_name                     = var.option_group_name_main
  parameter_group_name                  = var.parameter_group_name_main
  password                              = var.rds_password_main
  performance_insights_enabled          = var.performance_insights_enabled_main
  performance_insights_retention_period = var.performance_insights_enabled_main == true ? var.performance_insights_retention_period_main : null
  port                                  = var.port_main
  publicly_accessible                   = false
  replicate_source_db                   = null
  storage_encrypted                     = var.storage_encrypted_main
  storage_throughput                    = var.storage_throughput_main
  storage_type                          = var.storage_type_main

  tags = {
    Name = local.db_identifier
  }

  timeouts {
    create = lookup(var.timeouts_main, "create", null)
    delete = lookup(var.timeouts_main, "delete", null)
    update = lookup(var.timeouts_main, "update", null)
  }
  username = var.username_main

  vpc_security_group_ids = [
    aws_security_group.db_instance_sg.id
  ]

  #
  # safety measures
  #
  copy_tags_to_snapshot = true
  # do not delete automated backups
  delete_automated_backups = false

  deletion_protection = true
}

#Cross region REPLICA

resource "aws_db_instance" "read_replica_rds_main" {

  provider = aws.region2

  identifier = "${local.db_identifier}-replica"

  replicate_source_db         = aws_db_instance.rds_main.arn
  replica_mode                = "mounted"
  instance_class              = var.instance_class_main
  multi_az                    = var.multi_az_main
  skip_final_snapshot         = true
  backup_retention_period     = var.backup_retention_period_main
  manage_master_user_password = false
  kms_key_id                  = data.aws_kms_key.by_alias.arn
}