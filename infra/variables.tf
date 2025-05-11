variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
}

variable "log_bucket_name" {
  description = "S3 bucket name for logs"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)."
  type        = string
}

variable "rds_engine" {
  description = "The RDS engine type (e.g., mysql, postgres)."
  type        = string
}

# IAM SSM Policy ARNs
variable "ssm_policy_arns" {
  description = "List of SSM policy ARNs for EC2 instances"
  type        = list(string)
}

# IAM ECS Task Policy ARNs
variable "ecs_task_policy_arns" {
  description = "List of ECS task policy ARNs"
  type        = list(string)
}

# IAM ECS Execution Policy ARNs
variable "ecs_execution_policy_arns" {
  description = "List of ECS execution policy ARNs"
  type        = list(string)
}

# IAM S3 Policy ARNs
variable "s3_policy_arns" {
  description = "List of S3 policy ARNs for logging access"
  type        = list(string)
}

# Root Variables for Compute Module
# Region
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

# Region Suffix
variable "rgn_suffix" {
  description = "AWS region suffix"
  type        = string
}

# AZ Count
variable "az_count" {
  description = "Number of AZs to use"
  type        = number
}

# Owner
variable "owner" {
  description = "Owner of the resources"
  type        = string
}

# Jump Server Instance Type
variable "jump_server_instance_type" {
  description = "EC2 instance type for the jump server"
  type        = string
}

# Container Port
variable "container_port" {
  description = "Port on which the container is listening"
  type        = number
}

# ALB HTTPS Listener Port
variable "alb_https_listener_port" {
  description = "HTTPS port for ALB listener"
  type        = number
}

# Wildcard Domain Name
variable "wildcard_domain_name" {
  description = "Wildcard domain name for ALB"
  type        = string
}
