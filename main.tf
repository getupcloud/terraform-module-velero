locals {
  name_prefix = substr("${var.cluster_name}-velero", 0, 32)
}

data "aws_iam_policy_document" "aws_velero" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObject",
      "s3:AbortMultipartUpload",
      "s3:ListMultipartUploadParts"
    ]

    resources = [                
      "arn:aws:s3:::${var.customer_name}-eks-velero/*"
      ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::${var.customer_name}-eks-velero",
      ]
  }
}

resource "aws_iam_policy" "aws_velero" {
  name_prefix = local.name_prefix
  description = "Velero policy for EKS cluster ${var.cluster_name}"
  policy      = data.aws_iam_policy_document.aws_velero.json
}


module "irsa_aws_velero" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "~> 4.2"

  create_role                   = true
  role_name_prefix              = local.name_prefix
  provider_url                  = var.cluster_oidc_issuer_url
  role_policy_arns              = [aws_iam_policy.aws_velero.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.service_account_namespace}:${var.service_account_name}"]
}

resource "aws_s3_bucket" "aws_velero" {
  bucket = "${var.customer_name}-eks-velero"
  acl    = "private"

  tags = concat([{
    Name = "${var.cluster_name}"
  }], var.tags
  )
}