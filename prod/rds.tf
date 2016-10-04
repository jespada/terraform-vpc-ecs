# rds mysql example
# module "app-database" {
#   source             = "../modules/database/rds"
#   vpc_id             = "${module.network.vpc_id}"
#   //sgroups            = "${module.ecs.ecs_app_sg}"
#   sgroups            = "${aws_security_group.generic.id}" // use your app sg here
#   domain             = "${lookup(var.domain, var.env)}"
#   rds_instance_name  = "appdb"
#   rds_engine_version = "5.6.27"
#   rds_instance_class = "db.t2.small"
#   rds_is_multi_az    = "false"
#   rds_backup_window  = "03:54-04:24"
#   database_user      = "appuser"
#   database_password  = "coolpasswdxxXXX"
#   database_name      = "app"
#   db_subnets         = "${module.network.private_subnet_ids}"
