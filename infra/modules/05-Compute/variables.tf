# AWS Region
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

# Region Suffix (e.g., us-east-1 -> use1)
variable "rgn_suffix" {
  description = "AWS region suffix"
  type        = string
}

# Number of Availability Zones
variable "az_count" {
  description = "Number of AZs to use"
  type        = number
}

# Owner tag value
variable "owner" {
  description = "Owner of the resources"
  type        = string
}

# Environment tag value
variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

# EC2 Instance Type for Jump Server
variable "jump_server_instance_type" {
  description = "EC2 instance type for the jump server"
  type        = string
  default     = "t3.micro"
}

# Port the container listens on
variable "container_port" {
  description = "Port on which the container is listening"
  type        = number
}

# ALB HTTPS Listener Port
variable "alb_https_listener_port" {
  description = "HTTPS port for ALB listener"
  type        = number
}

# Wildcard domain name for SSL certificate lookup
variable "wildcard_domain_name" {
  description = "Wildcard domain name for ALB (e.g., *.example.com)"
  type        = string
}
