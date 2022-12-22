#blueprint wide
variable "app_name" {
  type        = string
  description = "Application name. May contain alphanum (case insensitive) and '-' (dash) chars only. Additionally, it must start with a letter, end with an alphanum char and dashes must not be consecutive."

  validation {
    condition     = can(regex("^[A-Za-z]+(?:[-][A-Za-z0-9]+)*$", var.app_name))
    error_message = "Name must consist of alphanum and '-' chars only. Additionally, it must start with a letter, end with an alphanum char and dashes must not be consecutive."
  }
}

variable "env" {
  type        = string
  description = "Application environment"
}

variable "assume_role_arn" {
  type        = string
  description = "ARN of the AWS IAM Role to assume by the Terraform runtime IAM entity during the deployment. Default: '' (none)"
  default     = ""
}

variable "r53_hosted_zone_name" {
  type        = string
  description = "Either existing Hosted Zone, created for the account or one to be provisioned if `var.is_create_hosted_zone` flag is checked. When left empty, Deployment's association with the Hosted Zone is ommited. Default value: ''"
  default    = ""
}

variable "is_create_hosted_zone" {
  type = bool
  description = "Specifies wether to dynamically provision Hosted Zone at the deployment runtime with the given `var.r53_hosted_zone_name` name. When checked and `var.r53_hosted_zone_name` is NOT provided - a validation error will occur. Default value: false"
  default     = false
}

variable "r53_parent_hosted_zone_name" {
  type        = string
  description = "Name of the Parent Hosted Zone to configure (being the superdomain of the `r53_hosted_zone`). Ignored if `var.is_create_hosted_zone` flag is unchecked. When left empty, registration of the provisioned Hosted Zone in the  parent Hosted Zone is skipped. Default value: ''"
  default     = ""
}

variable "ttl" {
  description = "R53 Hosted Zone NS record cacheing TTL in sec."
  type        = number
  default     = 300
}

variable "tags" {
  type        = map(string)
  description = "Application tags"
  default     = {}
}

# LP BASELINE TFC WORKSPACE REF
variable "tfc_auth_token" {
  type        = string
  description = "Terraform Cloud authentication token"
  sensitive   = true
}

variable "tfc_organization" {
  type        = string
  description = "Terraform Cloud Organization name"
  default     = "GammaTFCloud"
}

variable "tfc_workspace" {
  type        = string
  description = "TFC Workspace name in which LP baseline module is provisioned"
}
