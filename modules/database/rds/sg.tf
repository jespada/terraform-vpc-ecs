# Default Security Group for DB instances
resource "aws_security_group" "db" {
  name        = "${var.domain}-db-${var.rds_instance_name}"
  description = "Security Group for ${var.rds_instance_name} DB on ${var.domain} VPC"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${var.sg-minion}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${var.vpc_id}"
}
