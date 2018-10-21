variable "region" {
	default = "us-west-2"
}
variable "vpc_name" {
  default = "qa_blue"
}
variable "zonename" {
  default = "qablue.int"
  description = "mgmt blue the internal dns name"
}