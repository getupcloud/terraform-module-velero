output "config" {
  description = "Provider config"
  value       = lookup(local.output, var.provider_name)
}
