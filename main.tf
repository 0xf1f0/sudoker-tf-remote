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
  region = var.primary_region
}

data "aws_caller_identity" "current" {}

locals {
  resource_tags = {
    app_name = var.app_name
    env      = var.env
  }
}

# Create a new S3 bucket for terraform state storage
# State is stored locally
# TODO: Merge local with remote state


module "terraform_state_backend" {
  source = "cloudposse/tfstate-backend/aws"
  # Cloud Posse recommends pinning every module to a specific version
  version     = "0.38.1"
  for_each = var.bucket_list
  namespace  = "${var.app_name}-${each.value}"
  stage      = var.env
  name       = "terraform"
  attributes = ["state"]

  terraform_backend_config_file_path = "."
  terraform_backend_config_file_name = "${each.value}-backend.tf"
  force_destroy                      = false
}
