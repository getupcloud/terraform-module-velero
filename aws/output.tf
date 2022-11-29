output "bucket_name" {
  description = "Bucket name"
  value       = aws_s3_bucket.aws_velero.bucket
}

output "bucket_region" {
  description = "Bucket region"
  value       = aws_s3_bucket.aws_velero.region
}

### AUTH BY IRSA

output "iam_role_arn" {
  description = "ARN of IAM role"
  value       = local.use_oidc ? module.irsa_aws_velero[0].iam_role_arn : ""
}

output "iam_role_name" {
  description = "Name of IAM role"
  value       = local.use_oidc ? module.irsa_aws_velero[0].iam_role_name : ""
}

output "iam_role_path" {
  description = "Path of IAM role"
  value       = local.use_oidc ? module.irsa_aws_velero[0].iam_role_path : ""
}

output "iam_role_unique_id" {
  description = "Unique ID of IAM role"
  value       = local.use_oidc ? module.irsa_aws_velero[0].iam_role_unique_id : ""
}

### AUTH BY SECRET

output "iam_username" {
  description = "IAM Username"
  value       = local.use_iam ? aws_iam_user.aws_velero[0].name : ""
}

output "iam_access_key_id" {
  description = "IAM Acces Key Id"
  value       = local.use_iam ? aws_iam_access_key.aws_velero[0].id : ""
}

output "iam_secret_access_key" {
  description = "IAM Secret Access Key"
  value       = local.use_iam ? aws_iam_access_key.aws_velero[0].secret : ""
}
