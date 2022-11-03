variable "app_name" {
  type        = string
  description = "Name of the application"
}

variable "bucket_list" {
  type = set(string)
  description = "The set of buckets to create"
}

variable "primary_region" {
  type        = string
  description = "Primary AWS region"
}

variable "secondary_region" {
  type        = string
  description = "Secondary AWS region"
}

variable "env" {
  type        = string
  description = "Deployment/staging environment name; used as a tag"
}