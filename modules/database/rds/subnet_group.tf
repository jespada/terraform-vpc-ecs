resource "aws_db_subnet_group" "main_db_subnet_group" {
  name        = "${var.rds_instance_name}-private-db-${var.domain}"
  description = "RDS subnet group for ${var.domain}"
  subnet_ids  = ["${split(",", var.db_subnets)}"]
}
