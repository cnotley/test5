variable "app_name" {
    description = "Application name"
    type = string
}

variable "env" {
    description = "Application environment"
    type = string
}

variable "tags" {
    description = "Application tags"
    type = map(string)
    default = {
    }
}

variable "aws_account_id" {
    description = "AWS Account ID"
    type = string
    validation {
        condition = length(var.aws_account_id) > 0
        error_message = "Empty AWS account id."
    }
}

variable "aws_access_key_id" {
    description = "AWS Access Key ID"
    type = string
    validation {
        condition = length(var.aws_access_key_id) > 0
        error_message = "Empty AWS access key id."
    }
}

variable "aws_secret_access_key" {
    description = "AWS Secret Access Key"
    type = string
    sensitive = true
    validation {
        condition = length(var.aws_secret_access_key) > 0
        error_message = "Empty AWS secret access key."
    }
}

variable "aws_availability_zone" {
    description = "Availability zone"
    type = string
}

variable "aws_region" {
    description = "AWS region"
    type = string
    default = "us-east-1"
}

variable "aws_region_replication" {
    description = "AWS region replication"
    type = string
    default = "us-west-1"
}

variable "assume_role_arn" {
    description = "ARN of the AWS IAM Role to assume during the resources provisioning."
    type = string
    default = ""
}

variable "baseline_is_create_hosted_zone" {
    default = false
    description = "Specifies wether to dynamically provision Hosted Zone at the deployment runtime with the given `var.r53_hosted_zone_name` name. When checked and `var.r53_hosted_zone_name` is NOT provided - a validation error will occur. Default value: false"
    type = bool
}

variable "baseline_r53_hosted_zone_name" {
    default = ""
    description = "Either existing Hosted Zone, created for the account or one to be provisioned if `var.is_create_hosted_zone` flag is checked. When left empty, Deployment's association with the Hosted Zone is ommited. Default value: ''"
    type = string
}

variable "baseline_r53_parent_hosted_zone_name" {
    default = ""
    description = "Name of the Parent Hosted Zone to configure (being the superdomain of the `r53_hosted_zone`). Ignored if `var.is_create_hosted_zone` flag is unchecked. When left empty, registration of the provisioned Hosted Zone in the  parent Hosted Zone is skipped. Default value: ''"
    type = string
}

variable "baseline_tfc_auth_token" {
    description = "Terraform Cloud authentication token"
    sensitive = true
    type = string
}

variable "baseline_tfc_organization" {
    default = "GammaTFCloud"
    description = "Terraform Cloud Organization name"
    type = string
}

variable "baseline_tfc_workspace" {
    description = "TFC Workspace name in which LP baseline module is provisioned"
    type = string
}

variable "baseline_ttl" {
    default = 300
    description = "R53 Hosted Zone NS record cacheing TTL in sec."
    type = number
}

variable "ec2_admin_user_pub_key" {
    description = "The public SSH key to associate access with the admin user for all VMs"
    type = string
}

variable "ec2_ec2_image_name" {
    default = "ubuntu-focal-20.04"
    description = "EC2 image name"
    type = string
}

variable "ec2_ec2_instance_size" {
    default = "t2.micro"
    description = "EC2 size"
    type = string
}

