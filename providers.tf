provider "aws" {
    dynamic "assume_role" {
        content {
            role_arn = var.assume_role_arn
        }
        for_each = length(var.assume_role_arn) != 0 ? [1] : []
    }
    region = var.aws_region
    access_key = var.aws_access_key_id
    secret_key = var.aws_secret_access_key
}

provider "aws" {
    alias = "parent_hosted_zone"
    region = var.aws_region
    dynamic "assume_role" {
        content {
            role_arn = var.assume_role_arn
        }
        for_each = length(var.assume_role_arn) != 0 ? [1] : []
    }
    access_key = var.aws_access_key_id
    secret_key = var.aws_secret_access_key
}

provider "tfe" {
    token = var.baseline_tfc_auth_token
}

