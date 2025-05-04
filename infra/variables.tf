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
