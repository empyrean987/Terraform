# User Test Deployment

We will not discuss the VPC creation or terraform setup in this section but how user test stack is setup and deployed.

1. Setup your terraform environment

2. Clone the terraform repo

3. Next you will need to go to the user_test directory

4. When this stack is deployed it will deploy the user test instance in mgmt-blue vpc and deploy the py_user github repo and also run the chef_user cookbook

# DEPLOYMENT

We will deploy this stack and then login with the john.doe user created by chef on first boot.

➜  mgmt_blue git:(master) ✗ pwd

/Users/knoxm1/SOURCE/Terraform/user_test/mgmt_blue

➜  mgmt_blue git:(master) ✗ terraform apply

provider.aws.region

  The region where AWS operations will take place. Examples

  are us-east-1, us-west-2, etc.

  Default: us-east-1

  Enter a value: us-west-2


An execution plan has been generated and is shown below.

Resource actions are indicated with the following symbols:

  + create

 <= read (data resources)

Terraform will perform the following actions:

 <= data.template_cloudinit_config.cloudinit

      id:                                    <computed>

      base64_encode:                         "false"

      gzip:                                  "false"

      part.#:                                "1"

      part.0.content:                        "${data.template_file.config.rendered}"

      part.0.content_type:                   "text/cloud-config"

      part.0.filename:                       "init.cfg"

      rendered:                              <computed>

 <= data.template_file.config

      id:                                    <computed>

      rendered:                              <computed>

      template:                              "#cloud-confif\npackage_update: true\napt_upgrade: true\nruncmd:\n  - sleep 60\n  - [ git, clone, \"https://github.com/empyrean987/chef_user.git\", /home/ubuntu/chef_user ]\n  - sleep 10\n  - [ curl, -o, \"/home/ubuntu/chef_13.6.4-1_amd64.deb\",  \"https://packages.chef.io/files/stable/chef/13.6.4/ubuntu/16.04/chef_13.6.4-1_amd64.deb\" ]\n  - sleep 10\n  - [ curl, -o, \"/home/ubuntu/chefdk_2.4.17-1_amd64.deb\", \"https://packages.chef.io/files/stable/chefdk/2.4.17/ubuntu/16.04/chefdk_2.4.17-1_amd64.deb\" ]\n  - sleep 10 \n  - [ dpkg, -i, /home/ubuntu/chef_13.6.4-1_amd64.deb ]\n  - sleep 10\n  - [ dpkg, -i, /home/ubuntu/chefdk_2.4.17-1_amd64.deb ]\n  - sleep 60\n  - [ chef-solo, -c, /home/ubuntu/chef_user/chef-solo/solo.rb ]\n  - aws-ec2-assign-elastic-ip --valid-ips ${public_ip}\n# Capture all subprocess output into a logfile\n# Useful for troubleshooting cloud-init issues\noutput: {all: '| tee -a /var/log/cloud-init-output.log'}"
      vars.%:                                <computed>

  + aws_autoscaling_group.user_test

      id:                                    <computed>

      arn:                                   <computed>

      default_cooldown:                      <computed>

      desired_capacity:                      "1"

      force_delete:                          "true"

      health_check_grace_period:             "300"

      health_check_type:                     "EC2"

      launch_configuration:                  "${aws_launch_configuration.launch_config.id}"

      load_balancers.#:                      <computed>

      max_size:                              "1"

      metrics_granularity:                   "1Minute"

      min_size:                              "1"

      name:                                  "mgmt_blue_user_test"

      protect_from_scale_in:                 "false"

      service_linked_role_arn:               <computed>

      target_group_arns.#:                   <computed>

      termination_policies.#:                "1"

      termination_policies.0:                "NewestInstance"

      vpc_zone_identifier.#:                 "1"

      vpc_zone_identifier.814808159:         "subnet-0defcd4cafbe63312"

      wait_for_capacity_timeout:             "10m"

  + aws_eip.user_test_eip

      id:                                    <computed>

      allocation_id:                         <computed>

      association_id:                        <computed>

      domain:                                <computed>

      instance:                              <computed>

      network_interface:                     <computed>

      private_ip:                            <computed>

      public_ip:                             <computed>

      tags.%:                                "1"

      tags.Name:                             "mgmt_blue_user_test"

      vpc:                                   "true"

  + aws_launch_configuration.launch_config

      id:                                    <computed>

      associate_public_ip_address:           "false"

      ebs_block_device.#:                    <computed>

      ebs_optimized:                         <computed>

      enable_monitoring:                     "true"

      iam_instance_profile:                  "bastion_profile"

      image_id:                              "ami-0b999c06cd246018e"

      instance_type:                         "t2.micro"

      key_name:                              "knoxm1key"

      name:                                  <computed>

      root_block_device.#:                   <computed>

      security_groups.#:                     <computed>

      user_data:                             "1dd611d7ed1c3b5e7758b44a206ff3495b6c127a"

  + aws_route53_record.user_test_mgmt_blue_dns
      id:                                    <computed>

      allow_overwrite:                       "true"

      fqdn:                                  <computed>

      name:                                  "usertest.clevergirlcustoms.com"

      records.#:                             <computed>

      ttl:                                   "60"

      type:                                  "A"

      zone_id:                               "ZGNEQ4ZSHUCO5"

  + aws_security_group.user_test

      id:                                    <computed>

      arn:                                   <computed>

      description:                           "Managed by Terraform"

      egress.#:                              "2"

      egress.1403647648.cidr_blocks.#:       "1"

      egress.1403647648.cidr_blocks.0:       "0.0.0.0/0"

      egress.1403647648.description:         ""

      egress.1403647648.from_port:           "0"

      egress.1403647648.ipv6_cidr_blocks.#:  "0"

      egress.1403647648.prefix_list_ids.#:   "0"

      egress.1403647648.protocol:            "tcp"

      egress.1403647648.security_groups.#:   "0"

      egress.1403647648.self:                "false"

      egress.1403647648.to_port:             "65535"

      egress.2096121517.cidr_blocks.#:       "1"

      egress.2096121517.cidr_blocks.0:       "0.0.0.0/0"

      egress.2096121517.description:         ""

      egress.2096121517.from_port:           "0"

      egress.2096121517.ipv6_cidr_blocks.#:  "0"

      egress.2096121517.prefix_list_ids.#:   "0"

      egress.2096121517.protocol:            "udp"

      egress.2096121517.security_groups.#:   "0"

      egress.2096121517.self:                "false"

      egress.2096121517.to_port:             "65535"

      ingress.#:                             "1"

      ingress.2541437006.cidr_blocks.#:      "1"

      ingress.2541437006.cidr_blocks.0:      "0.0.0.0/0"

      ingress.2541437006.description:        ""

      ingress.2541437006.from_port:          "22"

      ingress.2541437006.ipv6_cidr_blocks.#: "0"

      ingress.2541437006.prefix_list_ids.#:  "0"

      ingress.2541437006.protocol:           "tcp"

      ingress.2541437006.security_groups.#:  "0"

      ingress.2541437006.self:               "false"

      ingress.2541437006.to_port:            "22"

      name:                                  "user_test"

      owner_id:                              <computed>

      revoke_rules_on_delete:                "false"

      vpc_id:                                "vpc-079844f0b66b958b8"


Plan: 5 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?

  Terraform will perform the actions described above.

  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_eip.user_test_eip: Creating...

  allocation_id:     "" => "<computed>"

  association_id:    "" => "<computed>"

  domain:            "" => "<computed>"

  instance:          "" => "<computed>"

  network_interface: "" => "<computed>"

  private_ip:        "" => "<computed>"

  public_ip:         "" => "<computed>"

  tags.%:            "" => "1"

  tags.Name:         "" => "mgmt_blue_user_test"

  vpc:               "" => "true"

aws_security_group.user_test: Creating...

  arn:                                   "" => "<computed>"

  description:                           "" => "Managed by Terraform"

  egress.#:                              "" => "2"

  egress.1403647648.cidr_blocks.#:       "" => "1"

  egress.1403647648.cidr_blocks.0:       "" => "0.0.0.0/0"

  egress.1403647648.description:         "" => ""

  egress.1403647648.from_port:           "" => "0"

  egress.1403647648.ipv6_cidr_blocks.#:  "" => "0"

  egress.1403647648.prefix_list_ids.#:   "" => "0"

  egress.1403647648.protocol:            "" => "tcp"

  egress.1403647648.security_groups.#:   "" => "0"

  egress.1403647648.self:                "" => "false"

  egress.1403647648.to_port:             "" => "65535"

  egress.2096121517.cidr_blocks.#:       "" => "1"

  egress.2096121517.cidr_blocks.0:       "" => "0.0.0.0/0"

  egress.2096121517.description:         "" => ""

  egress.2096121517.from_port:           "" => "0"

  egress.2096121517.ipv6_cidr_blocks.#:  "" => "0"

  egress.2096121517.prefix_list_ids.#:   "" => "0"

  egress.2096121517.protocol:            "" => "udp"

  egress.2096121517.security_groups.#:   "" => "0"

  egress.2096121517.self:                "" => "false"

  egress.2096121517.to_port:             "" => "65535"

  ingress.#:                             "" => "1"

  ingress.2541437006.cidr_blocks.#:      "" => "1"

  ingress.2541437006.cidr_blocks.0:      "" => "0.0.0.0/0"

  ingress.2541437006.description:        "" => ""

  ingress.2541437006.from_port:          "" => "22"

  ingress.2541437006.ipv6_cidr_blocks.#: "" => "0"

  ingress.2541437006.prefix_list_ids.#:  "" => "0"

  ingress.2541437006.protocol:           "" => "tcp"

  ingress.2541437006.security_groups.#:  "" => "0"

  ingress.2541437006.self:               "" => "false"

  ingress.2541437006.to_port:            "" => "22"

  name:                                  "" => "user_test"

  owner_id:                              "" => "<computed>"

  revoke_rules_on_delete:                "" => "false"

  vpc_id:                                "" => "vpc-079844f0b66b958b8"

aws_eip.user_test_eip: Creation complete after 2s (ID: eipalloc-0158bd4d496c781e9)

data.template_file.config: Refreshing state...

aws_route53_record.user_test_mgmt_blue_dns: Creating...

  allow_overwrite:    "" => "true"

  fqdn:               "" => "<computed>"

  name:               "" => "usertest.clevergirlcustoms.com"

  records.#:          "" => "1"

  records.1707226237: "" => "52.35.20.213"

  ttl:                "" => "60"

  type:               "" => "A"

  zone_id:            "" => "ZGNEQ4ZSHUCO5"

data.template_cloudinit_config.cloudinit: Refreshing state...

aws_security_group.user_test: Creation complete after 5s (ID: sg-0bcaf35b5937a9d4e)

aws_launch_configuration.launch_config: Creating...

  associate_public_ip_address: "" => "false"

  ebs_block_device.#:          "" => "<computed>"

  ebs_optimized:               "" => "<computed>"

  enable_monitoring:           "" => "true"

  iam_instance_profile:        "" => "bastion_profile"

  image_id:                    "" => "ami-0b999c06cd246018e"

  instance_type:               "" => "t2.micro"

  key_name:                    "" => "knoxm1key"

  name:                        "" => "<computed>"

  root_block_device.#:         "" => "<computed>"

  security_groups.#:           "" => "1"

  security_groups.4200649226:  "" => "sg-0bcaf35b5937a9d4e"

  user_data:                   "" => "500b7ca4b697743b20c9dc4b0e2736c5be45baee"

aws_launch_configuration.launch_config: Creation complete after 2s (ID: terraform-20181028004228152300000001)

aws_autoscaling_group.user_test: Creating...

  arn:                           "" => "<computed>"

  default_cooldown:              "" => "<computed>"

  desired_capacity:              "" => "1"

  force_delete:                  "" => "true"

  health_check_grace_period:     "" => "300"

  health_check_type:             "" => "EC2"

  launch_configuration:          "" => "terraform-20181028004228152300000001"

  load_balancers.#:              "" => "<computed>"

  max_size:                      "" => "1"

  metrics_granularity:           "" => "1Minute"

  min_size:                      "" => "1"

  name:                          "" => "mgmt_blue_user_test"

  protect_from_scale_in:         "" => "false"

  service_linked_role_arn:       "" => "<computed>"

  target_group_arns.#:           "" => "<computed>"

  termination_policies.#:        "" => "1"

  termination_policies.0:        "" => "NewestInstance"

  vpc_zone_identifier.#:         "" => "1"

  vpc_zone_identifier.814808159: "" => "subnet-0defcd4cafbe63312"

  wait_for_capacity_timeout:     "" => "10m"

aws_route53_record.user_test_mgmt_blue_dns: Still creating... (10s elapsed)

aws_autoscaling_group.user_test: Still creating... (10s elapsed)

aws_route53_record.user_test_mgmt_blue_dns: Still creating... (20s elapsed)

aws_autoscaling_group.user_test: Still creating... (20s elapsed)

aws_route53_record.user_test_mgmt_blue_dns: Still creating... (30s elapsed)

aws_autoscaling_group.user_test: Still creating... (30s elapsed)

aws_route53_record.user_test_mgmt_blue_dns: Still creating... (40s elapsed)

aws_autoscaling_group.user_test: Still creating... (40s elapsed)

aws_autoscaling_group.user_test: Creation complete after 41s (ID: mgmt_blue_user_test)

aws_route53_record.user_test_mgmt_blue_dns: Creation complete after 50s (ID: ZGNEQ4ZSHUCO5_usertest.clevergirlcustoms.com_A)

Apply complete! Resources: 5 added, 0 changed, 0 destroyed.

➜  mgmt_blue git:(master) ✗

# LOGIN

➜  .ssh ssh -i rsa_test.pem john.doe@usertest.clevergirlcustoms.com

The authenticity of host 'usertest.clevergirlcustoms.com (52.35.20.213)' can't be established.

ECDSA key fingerprint is SHA256:PEosnRJdgPSfH4UvI01X6SVafngHhCR9FgVIvt7ntb0.

Are you sure you want to continue connecting (yes/no)? yes

Warning: Permanently added 'usertest.clevergirlcustoms.com,52.35.20.213' (ECDSA) to the list of known hosts.

Enter passphrase for key 'rsa_test.pem':

Welcome to Ubuntu 16.04.5 LTS (GNU/Linux 4.4.0-1067-aws x86_64)

 * Documentation:  https://help.ubuntu.com

 * Management:     https://landscape.canonical.com

 * Support:        https://ubuntu.com/advantage

  Get cloud support with Ubuntu Advantage Cloud Guest:

    http://www.ubuntu.com/business/services/cloud

0 packages can be updated.

0 updates are security updates.


*** System restart required ***

The programs included with the Ubuntu system are free software;

the exact distribution terms for each program are described in the

individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by

applicable law.

john.doe@ip-192-168-0-156:~$