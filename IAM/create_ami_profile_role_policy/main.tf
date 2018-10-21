resource "aws_iam_role_policy" "create_ami_policy" {
  name        = "create_ami_policy"
  role        = "${aws_iam_role.create_ami_role.id}"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*",
        "ec2:CreateSnapshot",
        "ec2:CreateImage"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "create_ami_role" {
  name = "create_ami_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "create_ami_profile" {
  name = "create_ami_profile"
  role = "${aws_iam_role.create_ami_role.name}"
}