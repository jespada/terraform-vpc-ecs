resource "aws_alb" "alb-ecs" {
  name = "${var.name}-ecs-alb"
  security_groups = ["${aws_security_group.elb_ecs.id}"]
  subnets = ["${split(",", var.subnets_elb)}"]
  internal = true
}

resource "aws_alb_target_group" "app" {
  name     = "app"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_alb_listener" "app-alb" {
  load_balancer_arn = "${aws_alb.alb-ecs.arn}"
  port = "80"
  protocol = "HTTP"
  default_action {
    target_group_arn = "${aws_alb_target_group.app.arn}"
    type = "forward"
  }
}


resource "aws_route53_record" "app-ecs" {
  zone_id = "${var.zone_id}"
  name    = "{var.name}"
  type    = "A"

  alias {
    name                   = "${aws_alb.alb-ecs.dns_name}"
    zone_id                = "${aws_alb.alb-ecs.zone_id}"
    evaluate_target_health = false
  }
}


# http://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html
data "template_file" "ecs_task_template" {
  template = "${file("../modules/compute/ecs/templates/task.json.tpl")}"

  vars {
    image_repository_url = "${var.image_repository_url}"
    container_name = "${var.name}"
  }
}

resource "aws_ecs_task_definition" "ecs_task" {
  family = "${var.name}"
  container_definitions = "${data.template_file.ecs_task_template.rendered}"

  # volume {
  #   name = "sonar-home"
  #   host_path = "${var.sonar_host_dir}"
  # }
}

# http://docs.aws.amazon.com/AmazonECS/latest/developerguide/service_definition_paramters.html
resource "aws_ecs_service" "ecs-service" {
  name = "${var.name}"
  cluster = "${aws_ecs_cluster.ecs_cluster.id}"
  task_definition = "${aws_ecs_task_definition.ecs_task.arn}"
  iam_role = "${aws_iam_role.ecs_service_role.arn}"
  desired_count = "${var.desired_service_count}"
  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 100
  depends_on = [
    "aws_iam_role_policy.ecs_service_role_policy",
  ]

  load_balancer {
    target_group_arn = "${aws_alb_target_group.app.id}"
    container_name = "${var.name}"
    container_port = 8080
  }
  # We need to do this if we want to update task definitions/services from jenkins or somewhere else(https://concourse.ci/) when we deploy
  # lifecycle {
  #   ignore_changes = ["task_definition", "app"]
  # }
}
