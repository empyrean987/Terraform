resource "aws_vpc_dhcp_options" "dhcp" {
    domain_name = "${var.zonename}"
    domain_name_servers = ["AmazonProvidedDNS"]
    tags {
      Name = "mgmt blue internal"
    }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
    vpc_id = "${aws_vpc.vpc.id}"
    dhcp_options_id = "${aws_vpc_dhcp_options.dhcp.id}"
}

resource "aws_route53_zone" "main" {
  name = "${var.zonename}"
  vpc_id = "${aws_vpc.vpc.id}"
  comment = "Managed by terraform"
}
