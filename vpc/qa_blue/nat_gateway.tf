resource "aws_eip" "forNat" {
    vpc      = true
}
resource "aws_nat_gateway" "nat_gateway" {
    allocation_id = "${aws_eip.forNat.id}"
    subnet_id = "${aws_subnet.subnet_public_1.id}"
    depends_on = ["aws_internet_gateway.internet_gw"]
}