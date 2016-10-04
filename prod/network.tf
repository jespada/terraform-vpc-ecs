# VPC
module "network" {
  source = "../modules/network"

  name            = "${lookup(var.name, var.env)}"
  vpc_cidr        = "${lookup(var.vpc_cidr, var.env)}"
  azs             = "${var.azs}"
  region          = "${var.region}"
  private_subnets = "${lookup(var.private_subnets, var.env)}"
  public_subnets  = "${lookup(var.public_subnets, var.env)}"
  bastion_instance_type = "t2.micro"
  key_name        = "${lookup(var.key_name, var.env)}"

}

# DNS ZONE
module "dns_zone" {
  source = "../modules/dns_zones"

  vpc_id = "${module.network.vpc_id}"
  domain = "${lookup(var.domain, var.env)}"
}

# DNS resolver
resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id = "${module.network.vpc_id}"
  dhcp_options_id = "${module.dns_zone.dhcp_options_id}"
}

# Generic SG for ssh and ICMP

resource "aws_security_group" "generic" {
  name        = "${lookup(var.domain,var.env)}-generic"
  vpc_id = "${module.network.vpc_id}"
  description = "Generic SG for ssh and icmp for all instances"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${lookup(var.vpc_cidr, var.env)}"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
