terraform {
  required_version = ">= 0.12.2"

  backend "s3" {
    region         = "us-east-1"
    bucket         = "sudoker-authorizer-dev-terraform-state"
    key            = "terraform.tfstate"
    dynamodb_table = "sudoker-authorizer-dev-terraform-state-lock"
    profile        = ""
    role_arn       = ""
    encrypt        = "true"
  }
}