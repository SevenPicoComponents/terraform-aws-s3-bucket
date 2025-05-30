variable "attributes_override" {
  type    = list(string)
  default = null
}

variable "create_kms_key" {
  type    = bool
  default = false
}

variable "lifecycle_configuration_rules" {
  type    = any
  default = []
}

variable "force_destroy" {
  type    = bool
  default = false
}

variable "kms_key_source_policy_documents" {
  type    = list(string)
  default = []
}

variable "access_log_bucket_name" {
  type        = string
  default     = null
  description = "Name of the S3 bucket where S3 access logs will be sent to"
}

variable "access_log_bucket_prefix_override" {
  type        = string
  default     = null
  description = "Prefix to prepend to the current S3 bucket name, where S3 access logs will be sent to"
}

variable "kms_key_deletion_window_in_days" {
  type    = number
  default = 30
}

variable "kms_key_enable_key_rotation" {
  type    = bool
  default = true
}

variable "s3_source_policy_documents" {
  type        = list(string)
  default     = []
  description = <<-EOT
    List of IAM policy documents that are merged together into the exported document.
    Statements defined in source_policy_documents must have unique SIDs.
    Statement having SIDs that match policy SIDs generated by this module will override them.
    EOT
}

#variable "source_accounts" {
#  type = list(string)
#  default = []
#  description = "List of Account IDs allowed to write to this log bucket."
#}

variable "s3_replication_enabled" {
  type        = bool
  default     = false
  description = "Set this to true and specify `s3_replication_rules` to enable replication. `versioning_enabled` must also be `true`."
}

variable "s3_replication_rules" {
  type        = list(any)
  default     = null
  description = "Specifies the replication rules for S3 bucket replication if enabled. You must also set s3_replication_enabled to true."
}

variable "s3_replication_source_roles" {
  type        = list(string)
  default     = []
  description = "Cross-account IAM Role ARNs that will be allowed to perform S3 replication to this bucket (for replication within the same AWS account, it's not necessary to adjust the bucket policy)."
}

variable "s3_object_ownership" {
  type        = string
  default     = "BucketOwnerEnforced"
  description = "Specifies the S3 object ownership control. Valid values are `ObjectWriter`, `BucketOwnerPreferred`, and 'BucketOwnerEnforced'."
}

variable "enable_mfa_delete" {
  type        = bool
  default     = false
  description = "Set this to true to enable MFA on bucket. You must also set `enable_versioning` to `true`."
}

variable "enable_versioning" {
  type        = bool
  description = "Enable object versioning, keeping multiple variants of an object in the same bucket"
  default     = true
}

# Need input to be a list to fix https://github.com/cloudposse/terraform-aws-s3-bucket/issues/102
variable "privileged_principal_arns" {
  #  type        = map(list(string))
  #  default     = {}
  type    = list(map(list(string)))
  default = []

  description = <<-EOT
    List of maps. Each map has one key, an IAM Principal ARN, whose associated value is
    a list of S3 path prefixes to grant `privileged_principal_actions` permissions for that principal,
    in addition to the bucket itself, which is automatically included. Prefixes should not begin with '/'.
    EOT
}

variable "privileged_principal_actions" {
  type        = list(string)
  default     = []
  description = "List of actions to permit `privileged_principal_arns` to perform on bucket and bucket prefixes (see `privileged_principal_arns`)"
}

variable "s3_replica_bucket_arn" {
  type        = string
  default     = ""
  description = <<-EOT
    A single S3 bucket ARN to use for all replication rules.
    Note: The destination bucket can be specified in the replication rule itself
    (which allows for multiple destinations), in which case it will take precedence over this variable.
    EOT
}
