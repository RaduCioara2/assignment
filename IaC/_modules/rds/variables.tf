variable "multi_az_main" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "environment" {
  type = string
}

variable "instance_name" {
  description = "Prefix for the EC2 instance names"
  type        = string
}

variable "AZS" {
  description = "List of AZs for this account"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "allocated_storage_main" {
  description = "The allocated storage in gigabytes"
  type        = string
}

variable "allow_major_version_upgrade_main" {
  description = "Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible"
  type        = bool
  default     = false
}

variable "apply_immediately_main" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade_main" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  type        = bool
  default     = true
}

variable "availability_zone_main" {
  description = "The Availability Zone of the RDS instance"
  type        = string
  default     = ""
}

variable "backup_retention_period_main" {
  description = "The days to retain backups for"
  type        = number
  default     = 7
}

variable "backup_window_main" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string
}

variable "blue_green_update_enabled_main" {
  description = "Enables low-downtime updates when true"
  type        = bool
  default     = true
}

variable "db_name_main" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = null
}

variable "enabled_cloudwatch_logs_exports_main" {
  description = "List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL)."
  type        = list(string)
  default     = []
}

variable "engine_main" {
  description = "The database engine to use"
  type        = string
}

variable "engine_version_main" {
  description = "The engine version to use"
  type        = string
}

variable "iam_database_authentication_enabled_main" {
  description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled"
  type        = bool
  default     = false
}

variable "instance_class_main" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "iops_main" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1'. Can only be set when storage_type is 'io1' or 'gp3'. Cannot be specified for gp3 storage if the allocated_storage value is below a per-engine threshold."
  type        = number
  default     = null
}

variable "kms_key_id_main" {
  description = "The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used"
  type        = string
  default     = null
}

variable "maintenance_window_main" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = string
}

variable "max_allocated_storage_main" {
  description = "Specifies the value for Storage Autoscaling"
  type        = number
  default     = 0
}

variable "monitoring_interval_main" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
  type        = number
  default     = 0
}

variable "monitoring_role_name_main" {
  description = "Name of existing IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero."
  type        = string
  default     = "rds-monitoring-role"
}

variable "network_type_main" {
  description = "(Optional) The network type of the DB instance. Valid values: IPV4, DUAL"
  type        = string
  default     = "IPV4"
}

variable "option_group_name_main" {
  description = "Name of the DB option group to associate."
  type        = string
  default     = null
}

variable "parameter_group_name_main" {
  description = "Name of the DB parameter group to associate"
  type        = string
  default     = null
}

variable "rds_password_main" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
  type        = string
}

variable "performance_insights_enabled_main" {
  description = "Specifies whether Performance Insights are enabled"
  type        = bool
  default     = false
}

variable "performance_insights_retention_period_main" {
  description = "Amount of time in days to retain Performance Insights data. Valid values are 7, 731 (2 years) or a multiple of 31"
  type        = number
  default     = 7
}

variable "port_main" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = "5432"
}

variable "storage_encrypted_main" {
  description = "Specifies whether the DB instance is encrypted"
  type        = bool
  default     = false
}

variable "storage_throughput_main" {
  description = "The storage throughput value for the DB instance. Can only be set when storage_type is 'gp3'. Cannot be specified if the allocated_storage value is below a per-engine threshold."
  type        = string
  default     = null
}

variable "storage_type_main" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), 'gp3' (general purpose SSD that needs iops independently) or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'gp2' if not."
  type        = string
  default     = "gp3"
}

variable "username_main" {
  description = "Username for the master DB user"
  type        = string
}

variable "timeouts_main" {
  description = "(Optional) Updated Terraform resource management timeouts. Applies to `aws_db_instance` in particular to permit resource management times"
  type        = map(string)
  default = {
    create = "40m"
    update = "80m"
    delete = "60m"
  }
}