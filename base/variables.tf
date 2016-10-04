variable "access_key" {}
variable "secret_key" {}

variable "region" {
  default = "eu-west-1"
}

variable "tf_s3_bucket" {
  default = "terraform-app-states"
}
