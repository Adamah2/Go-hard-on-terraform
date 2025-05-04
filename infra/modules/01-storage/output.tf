output "bucket_id" {
  description = "ID of the created S3 bucket"
  value       = aws_s3_bucket.adamah.id
}

output "bucket_arn" {
  description = "ARN of the created S3 bucket"
  value       = aws_s3_bucket.adamah.arn
}

