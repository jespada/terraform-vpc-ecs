output "dns_ecs" {
  value = "[${aws_elb.elb_ecs.dns_name}]"
}

output "ecs_cluster_sg" {
  value = "${aws_security_group.ecs_cluster.id}"
}

output "latest_aws_ecs_ami" {
  value = "${data.aws_ami.latest_aws_ecs.image_id}"
}
