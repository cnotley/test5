# nonsensitive() function has to be explicitly called on Outputs originating from the different TFC
# workspace because of the current default behaviour of `tfe_outputs` data source.
# See: https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/outputs

output "vpc_id" {
  value = nonsensitive(data.tfe_outputs.baseline.values.vpc.vpc_id)
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = nonsensitive(data.tfe_outputs.baseline.values.vpc.public_route_table_ids[0])
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = nonsensitive(data.tfe_outputs.baseline.values.vpc.private_route_table_ids[0])
}

output "natgw_id" {
  description = "ID of the NAT Gateway"
  value       = nonsensitive(data.tfe_outputs.baseline.values.vpc.natgw_ids[0])
}

output "public_subnet_ids" {
  value = nonsensitive(data.tfe_outputs.baseline.values.vpc.public_subnets)
}

output "private_subnet_ids" {
  value = nonsensitive(data.tfe_outputs.baseline.values.vpc.private_subnets)
}

output "security_group_id" {
  value = aws_security_group.sg_default.id
}

output "hosted_zone_name" {
  description = "AWS R53 Hosted Zone name created for the deployment"
  value       = try(
    data.aws_route53_zone.preprovisioned[0].name, module.hosted_zone[0].hosted_zone_name, null)
}

output "hosted_zone_id" {
  description = "AWS R53 Hosted Zone id created for the deployment"
  value       = try(
    data.aws_route53_zone.preprovisioned[0].zone_id, module.hosted_zone[0].hosted_zone_id, null)
}

output "iam_role_name" {
  value = aws_iam_role.main_role.name
}

output "kms_key_arn" {
  value = module.platform_kms_key.key_arn
}

output "name_prefix" {
  value = local.name_prefix
}
