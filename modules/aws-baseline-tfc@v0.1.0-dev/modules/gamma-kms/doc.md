# Omnia Platform KMS CMK Terraform module

Terraform module which creates a KMS CMK on AWS.

## Usage

```hcl
module "platform_kms_key" {
  source = "git@github.com:BCG-OMNIA/terraform-aws-kms.git"
  tags   = module.platform_tags.common_tags
  name   = module.platform_tags.common_prefix
}
```

# Changes

## v3.0

- Support for Terraform 0.15
- Renamed `common_prefix` to `name`
- Removed `app_role_arn`, `name_override`, `service_override`, `service_version_override`
- Changed `tags` behaviour
