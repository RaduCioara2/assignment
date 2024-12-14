environment              = "development"
instance_name            = "webapp"

allocated_storage_main                     = 20
# upgrades
allow_major_version_upgrade_main           = true
apply_immediately_main                     = false
auto_minor_version_upgrade_main            = false

# availability_zone can only be set when multi_az is false
#  e.g.   "eu-west-1a"
multi_az                                   = true
availability_zone_main                     = ""
# backups
backup_retention_period_main               = 7
backup_window_main                         = "03:00-03:30"
engine_main                                = "postgres"
engine_version_main                        = "15.5"
instance_class_main                        = "db.t4g.micro"
maintenance_window_main                    = "Sun:07:00-Sun:07:30"
max_allocated_storage_main                 = 50
multi_az_main                              = false
parameter_group_name_main                  = "eib-postgres15"
# performance insights
performance_insights_enabled_main          = true
performance_insights_retention_period_main = 7
port_main                                  = "5959"
#rds_password     should be provided in a different manner so it does not reside in the state 
storage_encrypted_main                     = true
storage_type_main                          = "gp3"
username_main                              = "postgres"


