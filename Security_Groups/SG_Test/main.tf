module "SG_Test" {
  source              = "./modules/sg_test"
  app_id              = var.app_id
  app_dest_cidr       = var.app_dest_cidr
  dns_dest_cidr       = var.dns_dest_cidr
  vpc_id              = var.vpc_id
}

variable "app_id" {}
variable "app_dest_cidr" {}
variable "dns_dest_cidr" {}
variable "vpc_id" {}