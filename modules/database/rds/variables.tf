// Gral varibles
variable "domain" {}

variable "vpc_id" {}

variable "sg-minion" {}

// RDS Instance Variables

variable "rds_instance_name" {}

variable "rds_is_multi_az" {
  default = "true"
}

variable "rds_storage_type" {
  default = "gp2"
}

variable "rds_allocated_storage" {
  description = "The allocated storage in GBs"
  default     = "100"
}

variable "rds_engine_type" {
  // Valid types are
  // - mysql
  // - postgres
  // - oracle-*
  // - sqlserver-*
  // See http://docs.aws.amazon.com/cli/latest/reference/rds/create-db-instance.html
  // --engine
  default = "mysql"
}

variable "rds_engine_version" {
  // For valid engine versions, see:
  // See http://docs.aws.amazon.com/cli/latest/reference/rds/create-db-instance.html
  // --engine-version
}

variable "rds_instance_class" {}

// RDS Backup Variables
variable "rds_backup_window" {}

variable "rds_bkp_retention_period" {
  default = "7"
}

variable "database_name" {
  description = "The name of the database to create"
  default     = "app"
}

variable "database_user" {}

variable "database_password" {}

variable "db_parameter_group" {
  default = "default.mysql5.6"
}

variable "db_subnets" {}
