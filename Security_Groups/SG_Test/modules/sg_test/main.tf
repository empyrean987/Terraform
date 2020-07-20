resource "aws_security_group" "lambda_sg" {
	name = "${var.app_id}_lambda_sg"
	description = "${var.app_id} Lambda Application Security Group"
	vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "lambdaegressapp" {
	description = "${var.app_id} Application Security Group Rule"
	from_port = 514
	to_port = 514
	protocol = "tcp"
	cidr_blocks = ["${var.app_dest_cidr}"]
	type = "egress"
	security_group_id = aws_security_group.lambda_sg.id
}

resource "aws_security_group_rule" "lambdaegressdns" {
	description = "${var.app_id} Application Security Group Rule"
	from_port = 214
	to_port = 214
	protocol = "tcp"
	cidr_blocks = ["${var.dns_dest_cidr}"]
	type = "egress"
	security_group_id = aws_security_group.lambda_sg.id
}
