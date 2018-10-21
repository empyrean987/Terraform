variable "region" {
	default = "us-west-2"
}
variable "vpc_name" {
  default = "mgmt_blue"
}
variable "zonename" {
  default = "mgmtblue.int"
  description = "mgmt blue the internal dns name"
}