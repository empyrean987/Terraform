provider "aws" {
  region = var.region
  # ... other provider settings ...
}

module "SG_Test" {
  source              = "./modules/sg_test"
  app_id              = var.app_id
  app_dest_cidr       = var.app_dest_cidr
  dns_dest_cidr       = var.dns_dest_cidr
}

