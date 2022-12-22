resource "random_string" "random_prefix" {
  length  = 4
  upper   = false
  special = false
  numeric = false
}

locals {
  # Hacky workaround for cross-over variables validation. See: https://github.com/hashicorp/terraform/issues/25609
  # tflint-ignore: terraform_unused_declarations
  validate_hosted_zone_input = ( (var.is_create_hosted_zone && length(var.r53_hosted_zone_name) == 0) ?
    tobool("Validation error: Please specify Hosted Zone name that is to be provisioned.") : true
  )
  is_hosted_zone_preprovisioned = ( (length(var.r53_hosted_zone_name) != 0 && !var.is_create_hosted_zone) ?
    true : false )

  name_prefix = substr("${random_string.random_prefix.result}-${lower(var.app_name)}-${lower(var.env)}", 0, 21)
}


data "tfe_outputs" "baseline" {
  organization = var.tfc_organization
  workspace    = var.tfc_workspace
}

data "aws_route53_zone" "preprovisioned" {
  count = local.is_hosted_zone_preprovisioned ? 1 : 0

  name  = var.r53_hosted_zone_name
}

module "hosted_zone" {
  count              = var.is_create_hosted_zone ? 1 : 0
  source             = "git@github.com:gamma-falcon9-templates/gp-terraform-aws-hostedzone.git"

  hosted_zone_name   = var.r53_hosted_zone_name
  parent_hosted_zone = var.r53_parent_hosted_zone_name
  ttl                = var.ttl
  tags               = var.tags

  providers = {
    aws.parent_hosted_zone = aws.parent_hosted_zone
  }
}

module "platform_kms_key" {
  source = "./modules/gamma-kms"
  name   = "${local.name_prefix}-kms"
}

resource "aws_security_group" "sg_default" {
  name_prefix = "${local.name_prefix}-sg_default"
  description = "default security group"
  vpc_id      = data.tfe_outputs.baseline.values.vpc.vpc_id
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "default_ingress_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_default.id
}

resource "aws_security_group_rule" "default_ingress_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_default.id
}

resource "aws_security_group_rule" "default_ingress_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_default.id
}

resource "aws_security_group_rule" "default_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_default.id
}

resource "aws_iam_role" "main_role" {
  name = "${local.name_prefix}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = ["ec2.amazonaws.com", "ecs-tasks.amazonaws.com"]
        }
      },
    ]
  })
}

resource "aws_iam_policy" "kms_policy" {
  name        = "${local.name_prefix}-kms_policy"
  path        = "/"
  description = "Allow "

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "kms:*"
        ],
        "Resource" : "${module.platform_kms_key.key_arn}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "kms_role_attachment" {
  role       = aws_iam_role.main_role.name
  policy_arn = aws_iam_policy.kms_policy.arn
}
