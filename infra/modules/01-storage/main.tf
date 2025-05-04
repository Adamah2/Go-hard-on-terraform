resource "aws_s3_bucket" "adamah" {
  bucket = var.bucket_name
  tags   = var.tags
}

