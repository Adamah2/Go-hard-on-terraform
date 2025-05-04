locals {
  az_count            = 2
  ssm_vpc_param_name  = "/project/networking/vpc_id"
  ssm_subnets_name    = "/project/networking/public_subnet_ids"
  tags                = merge(var.tags, { Module = "networking" })
}
