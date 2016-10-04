resource "aws_security_group" "elb_ecs" {
  name = "${var.name}_ecs_elb"
  description = "Allows vpn and vpc traffic"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${var.sgroups}"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    security_groups = ["${var.sgroups}"]
  }
  ingress {
    from_port = 9091
    to_port = 9091
    protocol = "tcp"
    security_groups = ["${var.sgroups}"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

resource "aws_security_group" "ecs_cluster" {
  name = "${var.name}_ecs_cluster"
  description = "Allows all traffic for now.."
  vpc_id = "${var.vpc_id}"

  # TODO: maybe only ssh??
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = [
      "${aws_security_group.elb_ecs.id}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.name}"
}

resource "aws_autoscaling_group" "ecs-cluster" {
  #availability_zones = [
  #  "${var.availability_zone}"]
  name = "ASG ${var.name}"
  min_size = "${var.min_instance_count}"
  max_size = "${var.max_instance_count}"
  desired_capacity = "${var.desired_instance_capacity}"
  health_check_type = "EC2"
  health_check_grace_period = 300
  launch_configuration = "${aws_launch_configuration.ecs_cluster.name}"
  vpc_zone_identifier = ["${split(",", var.subnet_vpc)}"]

  tag {
    key = "Name"
    value = "ASG ${var.name}"
    propagate_at_launch = true
  }
}

data "template_file" "user_data" {
  template = "${file("../modules/compute/ecs/templates/user_data.tpl")}"

  vars {
    ecs_cluster_name = "${var.name}"
  }
}

# if we want dynamic autoscaling probably we will need this:
# http://docs.aws.amazon.com/AmazonECS/latest/developerguide/autoscale_IAM_role.html
data "aws_ami" "latest_aws_ecs" {
  most_recent = true
  filter {
    name = "description"
    values = ["Amazon Linux AMI *"]
  }
  filter {
    name = "description"
    values = ["* ECS HVM GP2"]
  }
  filter {
    name = "name"
    values = ["*-amazon-ecs-optimized"]
  }
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["591542846629"] # Amazon
}

resource "aws_launch_configuration" "ecs_cluster" {
  name = "ECS ${var.name}"
  image_id = "${data.aws_ami.latest_aws_ecs.id}"
  instance_type = "${var.instance_type}"
  security_groups = [
    "${aws_security_group.ecs_cluster.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.ecs_cluster.name}"
  key_name = "${var.key_name}"
  associate_public_ip_address = false
  user_data = "${data.template_file.user_data.rendered}"
}

resource "aws_iam_role" "ecs_host_role" {
  name = "${var.name}-ecs_host_role"
  assume_role_policy = "${file("../modules/compute/ecs/policies/ecs-role.json")}"
}

resource "aws_iam_role" "ecs_service_role" {
  name = "${var.name}-ecs_service_role"
  assume_role_policy = "${file("../modules/compute/ecs/policies/ecs-role.json")}"
}

resource "aws_iam_role_policy" "ecs_instance_role_policy" {
  name = "${var.name}-ecs_instance_role_policy"
  policy = "${file("../modules/compute/ecs/policies/ecs-instance-role-policy.json")}"
  role = "${aws_iam_role.ecs_host_role.id}"
}

resource "aws_iam_role_policy" "ecs_service_role_policy" {
  name = "${var.name}-ecs_service_role_policy"
  policy = "${file("../modules/compute/ecs/policies/ecs-service-role-policy.json")}"
  role = "${aws_iam_role.ecs_service_role.id}"
}

resource "aws_iam_instance_profile" "ecs_cluster" {
  name = "${var.name}-ecs-instance-profile"
  path = "/"
  roles = [
    "${aws_iam_role.ecs_host_role.name}"]
}
