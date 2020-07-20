variable "app_id" {
	default = "test"
	type = "string"
}

variable "region" {
	default = "us-east-1"
	type = "string"
}

variable "app_dest_cidr" {
	type = string
	default = "172.0.3.0/32"
}

variable "dns_dest_cidr" {
	type = string
	default = "192.168.10.1/32"
}