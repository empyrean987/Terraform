resource "aws_subnet" "subnet_private_1" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "192.168.16.0/25"
  tags {
        Name = "${var.vpc_name}_${var.region}a_private_1"
  }
 availability_zone = "${var.region}a"
}
resource "aws_subnet" "subnet_public_1" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "192.168.16.128/25"
  map_public_ip_on_launch = true
  tags {
        Name = "${var.vpc_name}_${var.region}a_public_1"
  }
  availability_zone = "${var.region}a"
}