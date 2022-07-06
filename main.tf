resource "aws_sns_topic" "this" {
  for_each = {for t in var.topics : "${try(t.name, "")}${try(t.name_prefix, "")}" => t}

  name                                     = try(each.value.name, null)
  name_prefix                              = try(each.value.name_prefix, null)
  display_name                             = try(each.value.display_name, null)
  policy                                   = try(each.value.policy, null)
  delivery_policy                          = try(each.value.delivery_policy, null)
  application_success_feedback_role_arn    = try(each.value.application_success_feedback_role_arn, null)
  application_success_feedback_sample_rate = try(each.value.application_success_feedback_sample_rate, null)
  application_failure_feedback_role_arn    = try(each.value.application_failure_feedback_role_arn, null)
  http_success_feedback_role_arn           = try(each.value.http_success_feedback_role_arn, null)
  http_success_feedback_sample_rate        = try(each.value.http_success_feedback_sample_rate, null)
  http_failure_feedback_role_arn           = try(each.value.http_failure_feedback_role_arn, null)
  lambda_success_feedback_role_arn         = try(each.value.lambda_success_feedback_role_arn, null)
  lambda_success_feedback_sample_rate      = try(each.value.lambda_success_feedback_sample_rate, null)
  lambda_failure_feedback_role_arn         = try(each.value.lambda_failure_feedback_role_arn, null)
  sqs_success_feedback_role_arn            = try(each.value.sqs_success_feedback_role_arn, null)
  sqs_success_feedback_sample_rate         = try(each.value.sqs_success_feedback_sample_rate, null)
  sqs_failure_feedback_role_arn            = try(each.value.sqs_failure_feedback_role_arn, null)
  kms_master_key_id                        = try(each.value.kms_master_key_id, null)
  fifo_topic                               = try(each.value.fifo_topic, null)
  content_based_deduplication              = try(each.value.content_based_deduplication, null)

  tags = var.tags
}

resource "aws_sns_topic_subscription" "sqs" {
  for_each = {for t in var.topics : "${try(t.name, "")}${try(t.name_prefix, "")}" => t if t.sqs_endpoint != null}

  topic_arn            = aws_sns_topic.this[each.key].arn
  protocol             = "sqs"
  endpoint             = each.value.sqs_endpoint
  raw_message_delivery = try(each.value.raw_message_delivery, null)
}
