terraform {
  required_version = ">= 0.15.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.5.0"
    }
  }
}

provider "aws" {
  region  = var.primary_region
}

provider "aws" {
  alias   = "secondary"
  region  = var.secondary_region
}


data "aws_caller_identity" "current" {}

locals {
  remote_bucket_name = "${var.app_name}-tf-remote-state"
  resource_tags = {
    app_name = var.app_name
    env      = var.env
  }
}

# Create a new S3 bucket for terraform state storage
# State is stored locally
# TODO: Merge local with remote state

module "remote_state" {
  source = "nozaq/remote-state-s3-backend/aws"
  providers = {
    aws         = aws
    aws.replica = aws.secondary
  }
  s3_bucket_name                         = local.remote_bucket_name
  s3_bucket_force_destroy                = true
  dynamodb_table_billing_mode            = var.dynamodb_table_billing_mode
  dynamodb_table_name                    = local.remote_bucket_name
  dynamodb_enable_server_side_encryption = true

  tags = local.resource_tags
}

resource "aws_iam_user" "terraform" {
  name = "TerraformUser"
  tags = local.resource_tags
}

resource "aws_iam_user_policy_attachment" "remote_state_access" {
  user       = aws_iam_user.terraform.name
  policy_arn = module.remote_state.terraform_iam_policy.arn
}
