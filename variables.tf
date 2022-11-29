variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
}

variable "customer_name" {
  description = "Customer name"
  type        = string
}

variable "provider_name" {
  description = "Provider where to configure velero resources"
  type        = string

  validation {
    condition     = contains(["aws"], var.provider_name)
    error_message = "Invalid provider name."
  }
}

variable "provider_aws" {
  description = "Config AWS Resources"
  type = object({
    bucket_name : string
    cluster_oidc_issuer_url : string
    service_account_namespace : string
    service_account_name : string
    tags : any
  })

  default = {
    bucket_name : ""
    cluster_oidc_issuer_url : ""
    service_account_namespace : "velero"
    service_account_name : "default"
    tags : {}
  }
}
