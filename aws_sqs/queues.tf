resource "signalfx_single_value_chart" "sfx_aws_sqs_queues_0" {
  color_by                = "Dimension"
  is_timestamp_hidden     = false
  max_precision           = 0
  name                    = "# Active Queues"
  program_text            = "A = data('NumberOfMessagesSent', filter=filter('namespace', 'AWS/SQS') and filter('stat', 'sum')).mean(over='15m').count(by=['QueueName', 'aws_region']).count().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "NumberOfMessagesSent - Mean(15m) - Count by QueueName,aws_region - Count"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_sqs_queues_1" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Total #Msg / Min"
  plot_type          = "ColumnChart"
  program_text       = <<-EOF
        A = data('NumberOfMessagesSent', filter=filter('stat', 'sum') and filter('namespace', 'AWS/SQS')).sum().scale(60).publish(label='A')
        B = data('NumberOfMessagesReceived', filter=filter('stat', 'sum') and filter('namespace', 'AWS/SQS')).sum().scale(60).publish(label='B')
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
    display_name = "NumberOfMessagesSent"
    label        = "A"
  }
  viz_options {
    axis         = "right"
    color        = "brown"
    display_name = "NumberOfMessagesReceived"
    label        = "B"
  }
}

resource "signalfx_time_chart" "sfx_aws_sqs_queues_2" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Total Sent Bytes / Min"
  plot_type          = "AreaChart"
  program_text       = "A = data('SentMessageSize', filter=filter('namespace', 'AWS/SQS') and filter('stat', 'sum')).scale(60).sum().publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "# bytes"
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
    display_name = "SentMessageSize - Scale:60 - Sum"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_sqs_queues_3" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top Queues #Msg Sent / Min"
  program_text            = "A = data('NumberOfMessagesSent', filter=filter('stat', 'sum') and filter('namespace', 'AWS/SQS')).scale(60).sum(by=['QueueName', 'aws_region']).top(count=5).publish(label='A')"
  secondary_visualization = "None"
  sort_by                 = "-value"
  unit_prefix             = "Metric"
}

resource "signalfx_list_chart" "sfx_aws_sqs_queues_4" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top Queues #Msg Recv / Min"
  program_text            = "A = data('NumberOfMessagesReceived', filter=filter('stat', 'sum') and filter('namespace', 'AWS/SQS')).scale(60).sum(by=['QueueName', 'aws_region']).top(count=5).publish(label='A')"
  secondary_visualization = "None"
  sort_by                 = "-value"
  unit_prefix             = "Metric"
}

resource "signalfx_list_chart" "sfx_aws_sqs_queues_5" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Age of oldest message (secs)"
  program_text            = "A = data('ApproximateAgeOfOldestMessage', filter=filter('namespace', 'AWS/SQS') and filter('stat', 'mean')).sum(by=['QueueName', 'aws_region']).publish(label='A')"
  secondary_visualization = "None"
  sort_by                 = "-value"
  unit_prefix             = "Metric"

  legend_options_fields {
    enabled  = false
    property = "sf_originatingMetric"
  }
  legend_options_fields {
    enabled  = false
    property = "namespace"
  }
  legend_options_fields {
    enabled  = true
    property = "sf_metric"
  }
  legend_options_fields {
    enabled  = true
    property = "QueueName"
  }
  legend_options_fields {
    enabled  = false
    property = "stat"
  }
  legend_options_fields {
    enabled  = true
    property = "aws_region"
  }

}

resource "signalfx_time_chart" "sfx_aws_sqs_queues_6" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Appx #Msg Visible"
  plot_type          = "LineChart"
  program_text       = "A = data('ApproximateNumberOfMessagesVisible', filter=filter('stat', 'mean') and filter('namespace', 'AWS/SQS')).mean(by=['QueueName', 'aws_region']).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "# messages"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "ApproximateNumberOfMessagesVisible"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_sqs_queues_7" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Appx #Msg Not Visible"
  plot_type          = "LineChart"
  program_text       = "A = data('ApproximateNumberOfMessagesNotVisible', filter=filter('stat', 'mean') and filter('namespace', 'AWS/SQS')).mean(by=['QueueName', 'aws_region']).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "# messages"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "ApproximateNumberOfMessagesNotVisible"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_sqs_queues_8" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Appx #Msg Delayed"
  plot_type          = "LineChart"
  program_text       = "A = data('ApproximateNumberOfMessagesDelayed', filter=filter('stat', 'mean') and filter('namespace', 'AWS/SQS')).mean(by=['QueueName', 'aws_region']).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "# messages"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "ApproximateNumberOfMessagesDelayed - Mean by QueueName,aws_region"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_sqs_queues_9" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Total #Msg Deleted / Min"
  plot_type          = "AreaChart"
  program_text       = "A = data('NumberOfMessagesDeleted', filter=filter('stat', 'sum') and filter('namespace', 'AWS/SQS')).sum().scale(60).publish(label='A')"
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
    display_name = "NumberOfMessagesDeleted"
    label        = "A"
  }
}

resource "signalfx_dashboard" "sfx_aws_sqs_queues" {

  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.sfx_aws_sqs.id
  name              = "SQS Queues"

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_sqs_queues_0.id
    row      = 0
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_sqs_queues_1.id
    row      = 0
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_sqs_queues_2.id
    row      = 0
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_sqs_queues_3.id
    row      = 1
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_sqs_queues_4.id
    row      = 1
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_sqs_queues_5.id
    row      = 1
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_sqs_queues_6.id
    row      = 2
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_sqs_queues_7.id
    row      = 2
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_sqs_queues_8.id
    row      = 3
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_sqs_queues_9.id
    row      = 3
    column   = 6
    height   = 1
    width    = 6
  }

}
