variable "app_name" {
  type        = string
  description = "Name of the application"
}

variable "primary_region" {
  type        = string
  description = "Primary AWS region"
}

variable "secondary_region" {
  type        = string
  description = "Secondary AWS region"
}

variable "dynamodb_table_billing_mode" {
  type        = string
  description = "Dynamodb table billing mode"
  default     = "PAY_PER_REQUEST"
}

variable "env" {
  type        = string
  description = "Deployment/staging environment name; used as a tag"
}