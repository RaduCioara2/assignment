resource "aws_sns_topic" "cpu_alarm_topic" {
  for_each = data.aws_instance.instances
  name     = "${each.key}-cpu-high-utilization-topic"
}

resource "aws_sns_topic" "memory_alarm_topic" {
  for_each = data.aws_instance.instances
  name     = "${each.key}-memory-high-utilization-topic"
}

resource "aws_sns_topic" "disk_alarm_topic" {
  for_each = data.aws_instance.instances
  name     = "${each.key}-disk-high-utilization-topic"
}