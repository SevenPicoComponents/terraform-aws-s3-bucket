output "bucket_id" {
  value = module.tfstate_storage.bucket_id
}

output "bucket_arn" {
  value = module.tfstate_storage.bucket_arn
}

output "bucket_fqdn" {
  value = module.tfstate_storage.bucket_domain_name
}

output "kms_key_arn" {
  value       = module.kms_key.key_arn
  description = "Key ARN"
}

output "kms_key_id" {
  value       = module.kms_key.key_id
  description = "Key ID"
}

output "kms_key_alias_arn" {
  value       = module.kms_key.alias_arn
  description = "Alias ARN"
}

output "kms_key_alias_name" {
  value       = module.kms_key.alias_name
  description = "Alias name"
}



