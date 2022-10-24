output "" {
  description = ""
  value       = module.irsa_aws_velero.iam_role_arn
}

output "bucket_name" {
  description = "Bucket name"
  value       = aws_s3_bucket.bucket
}

output "bucket_region" {
  description = "Bucket region"
  value       = aws_s3_bucket.region
}

output "iam_role_name" {
  description = "Name of IAM role"
  value       = module.irsa_aws_velero.iam_role_name
}

output "iam_role_path" {
  description = "Path of IAM role"
  value       = module.irsa_aws_velero.iam_role_path
}

output "iam_role_unique_id" {
  description = "Unique ID of IAM role"
  value       = module.irsa_aws_velero.iam_role_unique_id
}
