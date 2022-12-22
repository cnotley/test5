terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
      configuration_aliases = [aws.parent_hosted_zone]
    }
    tfe = {
      version = "~> 0.40.0"
    }
  }
  required_version = ">= 1.3.0"
}
