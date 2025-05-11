# Clean and Safe Locals File (IAM-safe names)

# Sanitize each variable to remove invalid IAM characters
locals {
  sanitized_owner = replace(replace(replace(replace(var.owner, " ", "-"), "#", ""), "/", ""), ":", "")
  sanitized_environment = replace(replace(replace(replace(var.environment, " ", "-"), "#", ""), "/", ""), ":", "")
  sanitized_region = replace(replace(replace(replace(var.region, " ", "-"), "#", ""), "/", ""), ":", "")

  # Build a safe name prefix for all resources
  name_prefix = "${local.sanitized_owner}-${local.sanitized_environment}-${local.sanitized_region}"
}

# Common tags (these don't affect IAM role names)
locals {
  common_tags = {
    Owner       = var.owner
    Environment = var.environment
    Region      = var.region
  }
}

# Safe IAM role and profile names
locals {
  ssm_role_name                = "${local.name_prefix}-geek-ssm-role"
  ssm_profile_name             = "${local.name_prefix}-geek-ssm-profile"
  ecs_task_role_name           = "${local.name_prefix}-geek-ecs-task-role"
  ecs_execution_role_name      = "${local.name_prefix}-geek-ecs-execution-role"
  ecs_task_execution_role_name = "${local.name_prefix}-geek-ecs-task-execution-role"
  ecs_service_role_name        = "${local.name_prefix}-geek-ecs-service-role"
  s3_role_name                 = "${local.name_prefix}-geek-s3-role"
}


