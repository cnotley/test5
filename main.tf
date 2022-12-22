module "baseline" {
    source = "./modules/aws-baseline-tfc@v0.1.0-dev"
    app_name = var.app_name
    assume_role_arn = var.assume_role_arn
    env = var.env
    is_create_hosted_zone = var.baseline_is_create_hosted_zone
    r53_hosted_zone_name = var.baseline_r53_hosted_zone_name
    r53_parent_hosted_zone_name = var.baseline_r53_parent_hosted_zone_name
    tags = var.tags
    tfc_auth_token = var.baseline_tfc_auth_token
    tfc_organization = var.baseline_tfc_organization
    tfc_workspace = var.baseline_tfc_workspace
    ttl = var.baseline_ttl
    providers = {
        aws.parent_hosted_zone = aws.parent_hosted_zone
    }
}

module "ec2" {
    source = "./modules/aws-ec2@v1.2.3-dev"
    admin_user_pub_key = var.ec2_admin_user_pub_key
    ec2_image_name = var.ec2_ec2_image_name
    ec2_instance_size = var.ec2_ec2_instance_size
    iam_role_name = module.baseline.iam_role_name
    install_script = <<EOF
        #!/bin/bash
        EOF
    kms_key_arn = module.baseline.kms_key_arn
    name_prefix = module.baseline.name_prefix
    public_subnet_ids = module.baseline.public_subnet_ids
    security_group_id = module.baseline.security_group_id
    tags = var.tags
    vpc_id = module.baseline.vpc_id
}

