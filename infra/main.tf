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

# IAM Module (Roles & Policies)
module "iam" {
  source                 = "./modules/04-IAM"
  region                 = var.aws_region
  rgn_suffix             = "eu-west-3"  # Example: this should match your AWS region suffix
  owner                  = "Emmanuel Adamah"  # This is the "owner" label we discussed
  environment            = var.environment
  ssm_policy_arns        = var.ssm_policy_arns
  ecs_task_policy_arns   = var.ecs_task_policy_arns
  ecs_execution_policy_arns = var.ecs_execution_policy_arns
  s3_policy_arns         = var.s3_policy_arns
}

# Create Compute Module
module "compute" {
  source                   = "./modules/05-compute"
  region                   = var.region
  rgn_suffix               = var.rgn_suffix
  az_count                 = var.az_count
  environment              = var.environment
  owner                    = var.owner
  jump_server_instance_type = var.jump_server_instance_type
  container_port           = var.container_port
  alb_https_listener_port  = var.alb_https_listener_port
  wildcard_domain_name     = var.wildcard_domain_name

  depends_on = [
    module.security,
    module.networking,
    module.storage,
    module.iam
  ]
}


