# AWS credentials and region
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

variable "access_key" {}

variable "secret_key" {}

//variable "key_path" {}

variable "env" {}
