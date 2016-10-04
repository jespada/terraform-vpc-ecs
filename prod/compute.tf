## test ecs cluster and service
# comment and apply if want to destroy ONLY this module

# module "app-ecs" {
#   source     = "../modules/compute/ecs"
#   name = "app"
#   zone_id    = "${module.dns_zone.private_dns_zone}"
#   key_name        = "${lookup(var.key_name, var.env)}"
#   access_key = "${var.access_key}"
#   secret_key = "${var.secret_key}"
#   vpc_id = "${module.network.vpc_id}"
#   sgroups = "${aws_security_group.generic.id}"
#   subnet_vpc = "${module.network.private_subnet_ids}"
#   subnets_elb = "${module.network.private_subnet_ids}"
# }
