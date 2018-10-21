resource "aws_vpc_peering_connection" "vpc_peering_connection" {
  vpc_id      = "vpc-079844f0b66b958b8"
  peer_vpc_id = "vpc-09fb18a3cabcb5ffc"
  auto_accept = true
  accepter {
    allow_remote_vpc_dns_resolution = true
  }
  requester {
    allow_remote_vpc_dns_resolution = true
  }
  tags {
    Name  = "mgmt_qa_vpc_peer"
  }
}

resource "aws_route" "private_mgmt_to_qa_route" {
  destination_cidr_block    = "192.168.16.0/20"
  route_table_id            = "rtb-027f57ae8a8c50f2a"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peering_connection.id}"
}

resource "aws_route" "public_mgmt_to_qa_route" {
  destination_cidr_block    = "192.168.16.0/20"
  route_table_id            = "rtb-0eea0bb584f49d79d"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peering_connection.id}"
}

resource "aws_route" "private_qa_to_mgmt_route" {
  destination_cidr_block    = "192.168.0.0/20"
  route_table_id            = "rtb-068110e16afa02dc4"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peering_connection.id}"
}

resource "aws_route" "public_qa_to_mgmt_route" {
  destination_cidr_block    = "192.168.0.0/20"
  route_table_id            = "rtb-0998e990517f7c272"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peering_connection.id}"
}

