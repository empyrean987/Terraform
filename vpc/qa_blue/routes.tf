resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
      Name = "${var.vpc_name}_${var.region}_public"
  }
  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.internet_gw.id}"
    }
}
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
      Name = "${var.vpc_name}_${var.region}_private"
  }
  route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.nat_gateway.id}"
  }
}
resource "aws_route_table_association" "public" {
    subnet_id = "${aws_subnet.subnet_public_1.id}"
    route_table_id = "${aws_route_table.public.id}"
}
resource "aws_route_table_association" "private" {
    subnet_id = "${aws_subnet.subnet_private_1.id}"
    route_table_id = "${aws_route_table.private.id}"
}