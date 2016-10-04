# AWS credentials and region
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

# resource "terraform_remote_state" "base_state" {
#   backend = "s3"
#   config {
#     bucket = "${var.tf_s3_bucket}"
#     region = "${var.region}"
#     key = "terraform.tfstate.base"
#   }
# }
