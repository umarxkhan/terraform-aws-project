resource "aws_sns_topic" "billing_alert" {
  name = "billing-alert-topic"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.billing_alert.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_cloudwatch_metric_alarm" "billing_alarm" {
  alarm_name          = "MonthlyBillingThreshold"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = 21600  # 6 hours
  statistic           = "Maximum"
  threshold           = 1.0      # Alert if monthly bill exceeds 
  alarm_description   = "Alert when estimated charges exceed "
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.billing_alert.arn]
  dimensions = {
    Currency = "USD"
  }
}
