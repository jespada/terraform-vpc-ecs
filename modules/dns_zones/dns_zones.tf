variable "domain" {}
variable "vpc_id" {}
variable "prefix_int_domain" { default = "int"}

#Public Hosted Zone (DNS)
resource "aws_route53_zone" "main" {
  name    = "${var.domain}"
  comment = " Public Zone  for ${var.domain}"
}


# Private Hosted Zone (DNS)
resource "aws_route53_zone" "int" {
  name    = "${var.prefix_int_domain}.${var.domain}"
  comment = "Internal Zone for ${var.domain}"
  vpc_id  = "${var.vpc_id}"
}


## DHCP
resource "aws_vpc_dhcp_options" "int_domain" {
  domain_name = "${var.prefix_int_domain}.${var.domain}"
  domain_name_servers = ["AmazonProvidedDNS"]
  ntp_servers = ["127.0.0.1"]
  tags {
    Name = "${var.prefix_int_domain}.${var.domain}"
  }
}


output "dhcp_options_id" {
  value = "${aws_vpc_dhcp_options.int_domain.id}"
}
output "public_dns_zone" {
  value = "${aws_route53_zone.main.id}"
}

output "private_dns_zone" {
  value = "${aws_route53_zone.int.id}"
}
