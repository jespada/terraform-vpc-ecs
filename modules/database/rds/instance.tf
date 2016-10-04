resource "aws_db_instance" "main_rds_instance" {
  identifier                = "${replace(var.domain, ".", "-")}-${var.rds_instance_name}"
  allocated_storage         = "${var.rds_allocated_storage}"
  engine                    = "${var.rds_engine_type}"
  engine_version            = "${var.rds_engine_version}"
  instance_class            = "${var.rds_instance_class}"
  name                      = "${var.database_name}"
  username                  = "${var.database_user}"
  password                  = "${var.database_password}"
  vpc_security_group_ids    = ["${aws_security_group.db.id}"]
  db_subnet_group_name      = "${aws_db_subnet_group.main_db_subnet_group.name}"
  parameter_group_name      = "${var.db_parameter_group}"
  multi_az                  = "${var.rds_is_multi_az}"
  storage_type              = "${var.rds_storage_type}"
  final_snapshot_identifier = "${replace(var.domain, ".", "-")}-${var.rds_instance_name}"
  skip_final_snapshot       = "false"
  backup_window             = "${var.rds_backup_window}"
  backup_retention_period   = "${var.rds_bkp_retention_period}"

  lifecycle {
    prevent_destroy = "true"
  }
}
