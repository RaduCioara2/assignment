#Prerequisites:
#  CloudWatch Agent: For metrics like memory and disk usage, you need to install the CloudWatch Agent on your EC2 instances.
#  By default, CloudWatch only collects CPU utilization metrics, so you need the agent to collect memory and disk metrics.
#  IAM Permissions: Ensure that the EC2 instances have the appropriate IAM role that allows the CloudWatch Agent to push metrics to CloudWatch.

# CloudWatch Alarms for CPU, Memory, and Disk for each instance
resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  for_each = data.aws_instance.instances

  alarm_name          = "CPU-High-Utilization-${each.key}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This alarm triggers when CPU usage is above 80% for ${each.key}"
  dimensions = {
    InstanceId = each.value
  }

  alarm_actions = [aws_sns_topic.cpu_alarm_topic[each.key].arn]
  ok_actions    = [aws_sns_topic.cpu_alarm_topic[each.key].arn]
}

resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
  for_each = data.aws_instance.instances

  alarm_name          = "Memory-High-Utilization-${each.key}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = "85"
  alarm_description   = "This alarm triggers when memory usage is above 85% for ${each.key}"
  dimensions = {
    InstanceId = each.value
  }

  alarm_actions = [aws_sns_topic.memory_alarm_topic[each.key].arn]
  ok_actions    = [aws_sns_topic.memory_alarm_topic[each.key].arn]
}

resource "aws_cloudwatch_metric_alarm" "disk_alarm" {
  for_each = data.aws_instance.instances

  alarm_name          = "Disk-High-Utilization-${each.key}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = "90"
  alarm_description   = "This alarm triggers when disk usage is above 90% for ${each.key}"
  dimensions = {
    InstanceId = each.value
  }

  alarm_actions = [aws_sns_topic.disk_alarm_topic[each.key].arn]
  ok_actions    = [aws_sns_topic.disk_alarm_topic[each.key].arn]
}
