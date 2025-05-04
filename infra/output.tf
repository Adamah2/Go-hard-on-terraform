output "storage_bucket_id" {
  description = "ID of the logging S3 bucket"
  value       = module.storage.bucket_id
}


output "storage_bucket_arn" {
  description = "ARN of the logging S3 bucket"
  value       = module.storage.bucket_arn
}



output "vpc_id" {
  description = "ID of the main VPC"
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.networking.private_subnet_ids
}
