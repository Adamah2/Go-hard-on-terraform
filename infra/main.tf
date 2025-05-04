locals {
  common_tags = {
    Project     = "GO-HARD-GO-HOME"
    Environment = "dev"
  }
}

module "storage" {
  source      = "./modules/01-storage"
  bucket_name = var.log_bucket_name
  tags        = local.common_tags
}


module "networking" {
  source   = "./modules/02-Networking"
  vpc_cidr = var.vpc_cidr
  tags     = local.common_tags
}

module "security" {
  source = "./modules/03-Security"
  project_name = var.project_name
  environment = var.environment
  vpc_id = module.networking.vpc_id
  rds_engine = var.rds_engine
}


