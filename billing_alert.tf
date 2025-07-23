resource "aws_sns_topic" "billing_alert" {
  name = "billing-alert-topic"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.billing_alert.arn
  protocol  = "email"
  endpoint  = "umar.mak@gmail.com"  
}

resource "aws_cloudwatch_metric_alarm" "billing_alarm" {
  alarm_name          = "MonthlyBillingThreshold"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "21600"  # 6 hours
  statistic           = "Maximum"
  threshold           = 1.0      # Alert if monthly bill exceeds $1
  alarm_description   = "Alert when estimated charges exceed $1"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.billing_alert.arn]
  dimensions = {
    Currency = "USD"
  }
}
