resource "aws_s3_bucket" "remote_state" {
  bucket = "${var.tf_s3_bucket}"
  acl    = "private"
  versioning {
        enabled = true
  }
}
