output "key_arn" {
  value       = aws_kms_key.this.arn
  description = "The Amazon Resource Name (ARN) of the key."
}

output "key_id" {
  value       = aws_kms_key.this.key_id
  description = "The globally unique identifier for the key."
}

output "key_alias_arn" {
  value       = aws_kms_alias.this.arn
  description = "The Amazon Resource Name (ARN) of the key alias."
}
