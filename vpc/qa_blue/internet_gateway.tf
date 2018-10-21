resource "aws_internet_gateway" "internet_gw" {
   vpc_id = "${aws_vpc.vpc.id}"
    tags {
        Name = "${var.vpc_name}_internet_gw"
    }
}