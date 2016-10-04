variable "name" {
  default = {
    prod    = "app-prod"
    testing = "app-testing"
  }
}

variable "domain" {
  default = {
    prod    = "app-prod.io"
    testing = "app-testing.io"
  }
}

variable "region" {
  default = "eu-west-1"
}

variable "tf_s3_bucket" {
  default = "terraform-app-states"
}

variable "azs" {
  type = "list"
  default = ["eu-west-1a","eu-west-1b","eu-west-1c"]
}

variable "vpc_cidr" {
  default = {
    prod    = "10.201.0.0/16"
    testing = "10.X.X.X/16"
  }
}

variable "private_subnets" {
  default = {
    prod = "10.201.10.0/24,10.201.20.0/24,10.201.30.0/24"
    testing = "XXXX/24"
  }
}

variable "public_subnets" {
  default = {
    prod = "10.201.40.0/24,10.201.50.0/24,10.201.60.0/24"
    testing = "XXXX/24"
  }
}

variable "key_name" {
  default = {
    prod = "admin-app-prod"
    testing = "admin-app-testing"
  }
}

variable "key_path" {}

variable "rds_multi_az" {
  default = {
    prod    = "true"
    testing = "false"
  }
}

variable "rds_backup_window" {
  default = {
    prod    = "00:25-00:55"
    testing = "03:54-04:24"
  }
}
