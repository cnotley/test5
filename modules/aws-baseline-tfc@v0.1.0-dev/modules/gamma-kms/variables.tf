variable "name" {
  type        = string
  description = "KMS CMK alias name."
}

variable "description" {
  default     = "Key for Product Usage on Platform Managed by Terraform"
  type        = string
  description = "The description of the key as viewed in AWS console."
}

variable "key_usage" {
  default     = "ENCRYPT_DECRYPT"
  type        = string
  description = "Specifies the intended use of the key."
}

variable "customer_master_key_spec" {
  default     = "SYMMETRIC_DEFAULT"
  type        = string
  description = "Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports."
}

variable "is_enabled" {
  default     = true
  type        = string
  description = "Specifies whether the key is enabled."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags applied to resources"
}
