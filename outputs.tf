output "sns_topic_arn" {
  description = "ARN of SNS topic"
  value       = {for k, v in aws_sns_topic.this : k => v.arn}
}

output "sns_topic_name" {
  description = "NAME of SNS topic"
  value       = {for k, v in aws_sns_topic.this : k => v.name}
}

output "sns_topic_id" {
  description = "ID of SNS topic"
  value       = {for k, v in aws_sns_topic.this : k => v.id}
}

output "sns_topic_owner" {
  description = "OWNER of SNS topic"
  value       = {for k, v in aws_sns_topic.this : k => v.owner}
}
