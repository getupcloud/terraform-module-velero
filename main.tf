locals {
  name_prefix = substr("${var.cluster_name}-velero", 0, 32)
  output = {
    aws : var.provider_name == "aws" ? module.aws[0] : tomap({})
    # aks : var.provider_name == "aks" ? module.aks[0] : tomap({})
  }

}

module "aws" {
  count  = var.provider_name == "aws" ? 1 : 0
  source = "./aws"

  name_prefix               = local.name_prefix
  cluster_name              = var.cluster_name
  customer_name             = var.customer_name
  bucket_name               = try(var.provider_aws.bucket_name, var.provider_aws_defaults.bucket_name)
  cluster_oidc_issuer_url   = try(var.provider_aws.cluster_oidc_issuer_url, var.provider_aws_defaults.cluster_oidc_issuer_url)
  service_account_namespace = try(var.provider_aws.service_account_namespace, var.provider_aws_defaults.service_account_namespace)
  service_account_name      = try(var.provider_aws.service_account_name, var.provider_aws_defaults.service_account_name)
  tags                      = try(var.provider_aws.tags, var.provider_aws_defaults.tags)
}

#module "aks" {
#  count  = var.provider_name == "aks" ? 1 : 0
#  source = "./aks"
#}
