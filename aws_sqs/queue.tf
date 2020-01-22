resource "signalfx_single_value_chart" "sfx_aws_sqs_queue_0" {
  color_by                = "Dimension"
  is_timestamp_hidden     = false
  max_precision           = 0
  name                    = "Messages Sent/Min"
  program_text            = "A = data('NumberOfMessagesSent', filter=filter('namespace', 'AWS/SQS') and filter('QueueName', 'MyQueue') and filter('stat', 'sum')).scale(60).publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "NumberOfMessagesSent - Scale:60"
    label        = "A"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_sqs_queue_1" {
  color_by                = "Dimension"
  is_timestamp_hidden     = false
  max_precision           = 0
  name                    = "Messages Received/Min"
  program_text            = "A = data('NumberOfMessagesReceived', filter=filter('namespace', 'AWS/SQS') and filter('QueueName', 'MyQueue') and filter('stat', 'sum')).scale(60).publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "NumberOfMessagesReceived - Scale:60"
    label        = "A"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_sqs_queue_2" {
  color_by                = "Dimension"
  is_timestamp_hidden     = false
  max_precision           = 0
  name                    = "Age of oldest message (secs)"
  program_text            = "A = data('ApproximateAgeOfOldestMessage', filter=filter('stat', 'mean')).publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "ApproximateAgeOfOldestMessage"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_sqs_queue_3" {
  color_by                = "Dimension"
  description             = "last reported interval"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Sent Message Size Stats"
  program_text            = "A = data('SentMessageSize', filter=filter('namespace', 'AWS/SQS') and filter('QueueName', 'MyQueue'), extrapolation='zero').sum(by=['stat']).publish(label='A')"
  secondary_visualization = "Sparkline"
  sort_by                 = "+stat"
  unit_prefix             = "Metric"
}

resource "signalfx_time_chart" "sfx_aws_sqs_queue_4" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Sent & Received Messages/Min"
  plot_type          = "ColumnChart"
  program_text       = <<-EOF
        A = data('NumberOfMessagesSent', filter=filter('namespace', 'AWS/SQS') and filter('QueueName', 'MyQueue') and filter('stat', 'sum')).scale(60).publish(label='A')
        B = data('NumberOfMessagesReceived', filter=filter('namespace', 'AWS/SQS') and filter('QueueName', 'MyQueue') and filter('stat', 'sum')).scale(60).publish(label='B')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "sent - BLUE"
    min_value = 0
  }

  axis_right {
    label     = "received - RED"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    color        = "blue"
    display_name = "NumberOfMessagesSent - Scale:60"
    label        = "A"
  }
  viz_options {
    axis         = "right"
    color        = "brown"
    display_name = "NumberOfMessagesReceived - Scale:60"
    label        = "B"
  }
}

resource "signalfx_list_chart" "sfx_aws_sqs_queue_5" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Queue Size Metrics"
  program_text            = <<-EOF
        A = data('ApproximateNumberOfMessagesDelayed', filter=filter('namespace', 'AWS/SQS') and filter('QueueName', 'MyQueue') and filter('stat', 'mean')).mean().publish(label='A')
        B = data('ApproximateNumberOfMessagesVisible', filter=filter('namespace', 'AWS/SQS') and filter('QueueName', 'MyQueue') and filter('stat', 'mean')).mean().publish(label='B')
        C = data('ApproximateNumberOfMessagesNotVisible', filter=filter('namespace', 'AWS/SQS') and filter('QueueName', 'MyQueue') and filter('stat', 'mean')).mean().publish(label='C')
    EOF
  secondary_visualization = "Sparkline"
  sort_by                 = "+sf_metric"
  unit_prefix             = "Metric"

  viz_options {
    display_name = "AppxMessagesDelayed"
    label        = "A"
  }
  viz_options {
    display_name = "AppxMessagesNotVisible"
    label        = "C"
  }
  viz_options {
    display_name = "AppxMessagesVisible"
    label        = "B"
  }
}

resource "signalfx_time_chart" "sfx_aws_sqs_queue_6" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Messages Deleted/Min"
  plot_type          = "AreaChart"
  program_text       = "A = data('NumberOfMessagesDeleted', filter=filter('namespace', 'AWS/SQS') and filter('QueueName', 'MyQueue') and filter('stat', 'sum')).scale(60).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "# messages"
    min_value = 0
  }

  axis_right {
    label     = "received - RED"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "NumberOfMessagesDeleted - Scale:60"
    label        = "A"
  }
}

resource "signalfx_text_chart" "sfx_aws_sqs_queue_7" {
  markdown = <<-EOF
        Empty charts indicate no activity of that category

        Docs for [SQS CloudWatch metrics](http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/sqs-metricscollected.html)
    EOF
  name     = "Notes"
}

resource "signalfx_dashboard" "sfx_aws_sqs_queue" {

  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.sfx_aws_sqs.id
  name              = "SQS Queue"

  variable {
    alias                  = "queue name"
    apply_if_exist         = false
    description            = "SQS Queue name"
    property               = "QueueName"
    replace_only           = false
    restricted_suggestions = false
    value_required         = false
    values                 = []
    values_suggested       = []
  }
  variable {
    alias                  = "region"
    apply_if_exist         = false
    description            = "AWS Region"
    property               = "aws_region"
    replace_only           = false
    restricted_suggestions = false
    value_required         = false
    values                 = []
    values_suggested       = []
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_sqs_queue_0.id
    row      = 0
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_sqs_queue_1.id
    row      = 0
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_sqs_queue_2.id
    row      = 0
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_sqs_queue_3.id
    row      = 1
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_sqs_queue_4.id
    row      = 1
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_sqs_queue_5.id
    row      = 1
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_sqs_queue_6.id
    row      = 2
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_text_chart.sfx_aws_sqs_queue_7.id
    row      = 2
    column   = 4
    height   = 1
    width    = 4
  }

}
