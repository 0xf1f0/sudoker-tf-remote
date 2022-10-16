output "iam-policy-arn" {
  value = module.remote_state.terraform_iam_policy.arn
}

output "bucket-domain-name" {
  value = module.remote_state.state_bucket.bucket_domain_name
}

output "bucket-name" {
  value = module.remote_state.state_bucket.bucket
}

output "kms-key-id" {
  value = module.remote_state.kms_key.id
}

output "dynamo_table_id" {
  value = module.remote_state.dynamodb_table.id
}