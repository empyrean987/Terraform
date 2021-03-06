resource "aws_security_group" "bastion" {
  name = "bastion"
  ingress {
    from_port = 22
	  to_port = 22
	  protocol = "tcp"
	  cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
	vpc_id = "vpc-079844f0b66b958b8"
}

resource "aws_eip" "bastion1_eip" {
  tags {
    Name    = "mgmt_blue_bastion"
  }
  vpc      = true
}

data "template_file" "config" {
  template = "${file("~/SOURCE/Terraform/bastion/mgmt_blue/cloud-init/bastion.yaml")}"
  vars {
    public_ip     = "${aws_eip.bastion1_eip.public_ip}"
  }
}

data "template_cloudinit_config" "cloudinit" {
  gzip = false
  base64_encode = false
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = "${data.template_file.config.rendered}"
  }
}

resource "aws_launch_configuration" "launch_config" {
  lifecycle { create_before_destroy = true }
  image_id              = "ami-0b999c06cd246018e"
  instance_type         = "t2.micro"
  iam_instance_profile  = "bastion_profile"
  key_name              = "knoxm1key"
  security_groups       = ["${aws_security_group.bastion.id}"]
  user_data             = "${data.template_cloudinit_config.cloudinit.rendered}"
  #user_data            = "#!/bin/bash -e\npip install aws-ec2-assign-elastic-ip\nsleep 10;aws-ec2-assign-elastic-ip  --valid-ips ${aws_eip.bastion1_eip.public_ip}"
  #user_data            = "#!/bin/bash -e\npip install aws-ec2-assign-elastic-ip\nsleep 10;aws-ec2-assign-elastic-ip  --valid-ips ${aws_eip.bastion1_eip.public_ip}\naws s3 cp s3://vdi-bootstrap/bootstrap16.sh ~/bootstrap.sh\n/bin/bash ~/bootstrap.sh"
}

resource "aws_autoscaling_group" "bastion" {
  lifecycle { create_before_destroy = true }
  depends_on                = ["aws_launch_configuration.launch_config"]
  name                      = "mgmt_blue_bastion"
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.launch_config.id}"
  vpc_zone_identifier       = ["subnet-0defcd4cafbe63312"]
  termination_policies      = ["NewestInstance"]
}

resource "aws_route53_record" "bastion_mgmt_blue_dns" {
  zone_id = "ZGNEQ4ZSHUCO5"
  name    = "bst1.clevergirlcustoms.com"
  type    = "A"
  ttl     = "60"
  records = ["${aws_eip.bastion1_eip.public_ip}"]
}
