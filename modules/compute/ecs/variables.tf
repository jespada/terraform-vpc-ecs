variable "access_key" {}

variable "secret_key" {}

variable "name" {
  description = "The name of the Amazon ECS cluster."
}

//variable "ssl_name" {}

variable "vpc_id" {
  description = "VPC where we want our stuff to run"
}

variable "sgroups" {}

variable "subnet_vpc" {}

variable "subnets_elb" {}


variable "region" {
  description = "The AWS region to create resources in."
  default = "eu-west-1"
}

variable "availability_zone" {
  description = "The availability zone"
  default = "eu-west-1a"
}


variable "instance_type" {
  default = "t2.medium"
}

variable "key_name" {
  description = "SSH key name in your AWS account for AWS instances."
}

variable "min_instance_count" {
  default = 1
  description = "Minimum number of EC2 instances."
}

variable "max_instance_count" {
  default = 2
  description = "Maximum number of EC2 instances."
}

variable "desired_instance_capacity" {
  default = 1
  description = "Desired number of EC2 instances."
}

variable "desired_service_count" {
  default = 1
  description = "Desired number of ECS services."
}

variable "image_repository_url" {
  default = "aws-aacounti-here.dkr.ecr.eu-west-1.amazonaws.com/container-name:version"
  description = "docker hub Repository  or aws ECR for for your app"
}

variable "zone_id" {}
