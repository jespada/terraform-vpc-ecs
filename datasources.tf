data "terraform_remote_state" "base_state" {
  backend = "s3"
  config {
    bucket = "${var.tf_s3_bucket}"
    region = "${var.region}"
    key = "terraform.tfstate.base"
  }
}

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
