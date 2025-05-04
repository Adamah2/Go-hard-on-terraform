locals {
  ssm_param_name = "/project/storage/adamah"
  default_acl    = "log-delivery-write"
  tags           = merge(var.tags, { Module = "storage" })
}
