# Variables for IAM module

# AWS Region
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

# Region Suffix
variable "rgn_suffix" {
  description = "AWS region suffix"
  type        = string
}

# Owner of the resources
variable "owner" {
  description = "Owner of the resources"
  type        = string
}

# Environment (e.g., dev, staging, prod)
variable "environment" {
  description = "Environment name"
  type        = string
}

# List of SSM Policy ARNs to attach to the EC2 SSM Role
variable "ssm_policy_arns" {
  description = "List of Amazon SSM Policy ARNs"
  type        = list(string)
}

# List of ECS Task Managed Policy ARNs
variable "ecs_task_policy_arns" {
  description = "List of Amazon ECS Task Policy ARNs"
  type        = list(string)
}

# List of ECS Execution Managed Policy ARNs
variable "ecs_execution_policy_arns" {
  description = "List of Amazon ECS Execution Policy ARNs"
  type        = list(string)
}

# List of S3 Policy ARNs for S3 access role
variable "s3_policy_arns" {
  description = "List of Amazon S3 Policy ARNs"
  type        = list(string)
}

# Uncomment if you plan to use ECS Service Role
# variable "ecs_service_policy_arns" {
#   description = "List of Amazon ECS Service Policy ARNs"
#   type        = list(string)
# }
