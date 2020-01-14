resource "signalfx_single_value_chart" "sfx_aws_dynamodb_instances_req_latency" {
  color_by                = "Dimension"
  description             = "Successful requests to DynamoDB or Amazon DynamoDB Streams during the specified time period."
  max_precision           = 3
  name                    = "Average Request Latency (ms)"
  program_text            = "A = data('SuccessfulRequestLatency', filter=filter('namespace', 'AWS/DynamoDB') and filter('stat', 'mean')).mean().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "SuccessfulRequestLatency - Mean"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_dynamodb_instances_req_latency_history" {
  axes_include_zero         = false
  axes_precision            = 0
  color_by                  = "Dimension"
  description               = "Successful requests to DynamoDB or Amazon DynamoDB Streams during the specified time period."
  disable_sampling          = false
  minimum_resolution        = 0
  name                      = "Average Request Latency (ms)"
  on_chart_legend_dimension = "Operation"
  plot_type                 = "LineChart"
  program_text              = "A = data('SuccessfulRequestLatency', filter=filter('namespace', 'AWS/DynamoDB') and filter('stat', 'mean')).publish(label='A')"
  show_data_markers         = true
  show_event_lines          = false
  stacked                   = false
  time_range                = 3600
  unit_prefix               = "Metric"

  histogram_options {
    color_theme = "red"
  }

  legend_options_fields {
    enabled  = false
    property = "AWSUniqueId"
  }
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
    property = "Operation"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_metric"
  }
  legend_options_fields {
    enabled  = false
    property = "stat"
  }
  legend_options_fields {
    enabled  = true
    property = "TableName"
  }

  viz_options {
    axis         = "left"
    display_name = "SuccessfulRequestLatency"
    label        = "A"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_dynamodb_instances_throttled" {
  color_by                = "Dimension"
  description             = "Requests to DynamoDB that exceed the provisioned throughput limits on a resource (such as a table or an index)."
  max_precision           = 0
  name                    = "Throttled Requests"
  program_text            = "A = data('ThrottledRequests', filter=filter('namespace', 'AWS/DynamoDB') and filter('stat', 'sum'), rollup='sum').sum().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    color        = "yellow"
    display_name = "ThrottledRequests - Sum"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_dynamodb_instances_throttled_history" {
  axes_include_zero         = false
  axes_precision            = 0
  color_by                  = "Dimension"
  description               = "Requests to DynamoDB that exceed the provisioned throughput limits on a resource (such as a table or an index)."
  disable_sampling          = false
  minimum_resolution        = 0
  name                      = "Throttled Requests"
  on_chart_legend_dimension = "Operation"
  plot_type                 = "AreaChart"
  program_text              = "A = data('ThrottledRequests', filter=filter('namespace', 'AWS/DynamoDB') and filter('stat', 'sum'), rollup='sum').publish(label='A')"
  show_data_markers         = true
  show_event_lines          = false
  stacked                   = true
  time_range                = 3600
  unit_prefix               = "Metric"

  histogram_options {
    color_theme = "red"
  }

  legend_options_fields {
    enabled  = false
    property = "AWSUniqueId"
  }
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
    property = "Operation"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_metric"
  }
  legend_options_fields {
    enabled  = false
    property = "stat"
  }
  legend_options_fields {
    enabled  = true
    property = "TableName"
  }

  viz_options {
    axis         = "left"
    display_name = "ThrottledRequests"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_dynamodb_instances_user_errors_history" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "Requests to DynamoDB or Amazon DynamoDB Streams that generate an HTTP 400 status code during the specified time period."
  disable_sampling   = false
  minimum_resolution = 0
  name               = "User Errors"
  plot_type          = "ColumnChart"
  program_text       = "A = data('UserErrors', filter=filter('namespace', 'AWS/DynamoDB') and filter('sf_metric', 'UserErrors') and filter('stat', 'sum'), rollup='sum').publish(label='A')"
  show_data_markers  = true
  show_event_lines   = false
  stacked            = false
  time_range         = 3600
  unit_prefix        = "Metric"

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    color        = "brown"
    display_name = "UserErrors"
    label        = "A"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_dynamodb_instances_user_errors" {
  color_by                = "Dimension"
  description             = "Requests to DynamoDB or DynamoDB Streams that generate an HTTP 400 status code during the specified time period."
  max_precision           = 0
  name                    = "User Errors"
  program_text            = "A = data('UserErrors', filter=filter('namespace', 'AWS/DynamoDB') and filter('sf_metric', 'UserErrors') and filter('stat', 'sum'), rollup='sum').publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    color        = "brown"
    display_name = "UserErrors"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_dynamodb_instances_system_errors_history" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "Requests to DynamoDB or Amazon DynamoDB Streams that generate an HTTP 500 status code during the specified time period."
  disable_sampling   = false
  minimum_resolution = 0
  name               = "System Errors"
  plot_type          = "AreaChart"
  program_text       = "A = data('SystemErrors', filter=filter('namespace', 'AWS/DynamoDB') and filter('stat', 'sum') and filter('TableName', '*') and filter('Operation', '*'), rollup='sum').publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = true
  time_range         = 900
  unit_prefix        = "Metric"

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "SystemErrors"
    label        = "A"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_dynamodb_instances_system_errors" {
  color_by                = "Dimension"
  description             = "Requests to DynamoDB or Amazon DynamoDB Streams that generate an HTTP 500 status code during the specified time period."
  max_precision           = 0
  name                    = "System Errors"
  program_text            = "A = data('SystemErrors', filter=filter('namespace', 'AWS/DynamoDB') and filter('stat', 'sum') and filter('TableName', '*') and filter('Operation', '*'), rollup='sum').publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    color        = "brown"
    display_name = "SystemErrors"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_dynamodb_instances_read_cap_pct" {
  axes_include_zero         = false
  axes_precision            = 0
  color_by                  = "Dimension"
  description               = "The percentage of read capacity units consumed over the specified time period, so you can track how much of your provisioned throughput is used."
  disable_sampling          = false
  minimum_resolution        = 0
  name                      = "Percentage of Read Capacity Consumed"
  on_chart_legend_dimension = "TableName"
  plot_type                 = "LineChart"
  program_text              = <<-EOF
        A = data('ProvisionedReadCapacityUnits', filter=filter('namespace', 'AWS/DynamoDB') and filter('stat', 'mean') and filter('TableName', '*')).publish(label='A', enable=False)
        B = data('ConsumedReadCapacityUnits', filter=filter('namespace', 'AWS/DynamoDB') and filter('stat', 'mean') and filter('TableName', '*')).publish(label='B', enable=False)
        C = ((B/A)*100).publish(label='C')
    EOF
  show_data_markers         = true
  show_event_lines          = false
  stacked                   = false
  time_range                = 3600
  unit_prefix               = "Metric"

  histogram_options {
    color_theme = "red"
  }

  legend_options_fields {
    enabled  = false
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_originatingMetric"
  }
  legend_options_fields {
    enabled  = false
    property = "namespace"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_metric"
  }
  legend_options_fields {
    enabled  = false
    property = "stat"
  }
  legend_options_fields {
    enabled  = true
    property = "TableName"
  }

  viz_options {
    axis         = "left"
    display_name = "ConsumedReadCapacityUnits"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "Percentage of Read Capacity Consumed"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    display_name = "ProvisionedReadCapacityUnits"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_dynamodb_instances_write_cap_pct" {
  axes_include_zero         = false
  axes_precision            = 0
  color_by                  = "Dimension"
  description               = "The percentage of write capacity units consumed over the specified time period, so you can track how much of your provisioned throughput is used."
  disable_sampling          = false
  minimum_resolution        = 0
  name                      = "Percentage of Write Capacity Consumed"
  on_chart_legend_dimension = "TableName"
  plot_type                 = "LineChart"
  program_text              = <<-EOF
        A = data('ProvisionedWriteCapacityUnits', filter=filter('namespace', 'AWS/DynamoDB') and filter('stat', 'mean') and filter('TableName', '*')).publish(label='A', enable=False)
        B = data('ConsumedWriteCapacityUnits', filter=filter('namespace', 'AWS/DynamoDB') and filter('stat', 'mean') and filter('TableName', '*')).publish(label='B', enable=False)
        C = ((B/A)*100).publish(label='C')
    EOF
  show_data_markers         = true
  show_event_lines          = false
  stacked                   = false
  time_range                = 3600
  unit_prefix               = "Metric"

  histogram_options {
    color_theme = "red"
  }

  legend_options_fields {
    enabled  = false
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_originatingMetric"
  }
  legend_options_fields {
    enabled  = false
    property = "namespace"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_metric"
  }
  legend_options_fields {
    enabled  = false
    property = "stat"
  }
  legend_options_fields {
    enabled  = true
    property = "TableName"
  }

  viz_options {
    axis         = "left"
    display_name = "ConsumedWriteCapacityUnits"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "Percentage of Write Capacity Consumed"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    color        = "green"
    display_name = "ProvisionedWriteCapacityUnits"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_dynamodb_instances_read_throttles" {
  axes_include_zero         = false
  axes_precision            = 0
  color_by                  = "Dimension"
  description               = "Requests to DynamoDB that exceed the provisioned read capacity units for a table or a global secondary index."
  disable_sampling          = false
  minimum_resolution        = 0
  name                      = "Read Throttle Events"
  on_chart_legend_dimension = "TableName"
  plot_type                 = "AreaChart"
  program_text              = "A = data('ReadThrottleEvents', filter=filter('stat', 'sum') and filter('TableName', '*'), rollup='sum').publish(label='A')"
  show_data_markers         = true
  show_event_lines          = false
  stacked                   = true
  time_range                = 3600
  unit_prefix               = "Metric"

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    color        = "lilac"
    display_name = "ReadThrottleEvents"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_dynamodb_instances_write_throttles" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "Requests to DynamoDB that exceed the provisioned write capacity units for a table or a global secondary index."
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Write Throttle Events"
  plot_type          = "AreaChart"
  program_text       = "A = data('WriteThrottleEvents', filter=filter('namespace', 'AWS/DynamoDB') and filter('stat', 'sum') and filter('TableName', '*'), rollup='sum').publish(label='A')"
  show_data_markers  = true
  show_event_lines   = false
  stacked            = true
  time_range         = 900
  unit_prefix        = "Metric"

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    color        = "orange"
    display_name = "WriteThrottleEvents"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_dynamodb_instances_returned_items" {
  axes_include_zero         = false
  axes_precision            = 0
  color_by                  = "Dimension"
  description               = "The number of items returned by Query or Scan operations during the specified time period."
  disable_sampling          = false
  minimum_resolution        = 0
  name                      = "Returned Item Count"
  on_chart_legend_dimension = "Operation"
  plot_type                 = "LineChart"
  program_text              = "A = data('ReturnedItemCount', filter=filter('namespace', 'AWS/DynamoDB') and filter('TableName', '*') and filter('Operation', '*') and filter('stat', 'count'), rollup='sum').publish(label='A')"
  show_data_markers         = true
  show_event_lines          = false
  stacked                   = false
  time_range                = 3600
  unit_prefix               = "Metric"

  histogram_options {
    color_theme = "red"
  }

  legend_options_fields {
    enabled  = false
    property = "AWSUniqueId"
  }
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
    property = "Operation"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_metric"
  }
  legend_options_fields {
    enabled  = false
    property = "stat"
  }
  legend_options_fields {
    enabled  = true
    property = "TableName"
  }

  viz_options {
    axis         = "left"
    display_name = "ReturnedItemCount"
    label        = "A"
  }
}

resource "signalfx_dashboard" "sfx_aws_dynamodb_instances" {
  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.sfx_aws_dynamodb.id
  description       = "Amazon DynamoDB is a fully managed NoSQL database service that provides fast and predictable performance with seamless scalability. DynamoDB lets you offload the administrative burdens of operating and scaling a distributed database, so that you don't have to worry about hardware provisioning, setup and configuration, replication, software patching, or cluster scaling."
  name              = "AWS DynamoDB"

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_dynamodb_instances_req_latency.id
    row      = 0
    column   = 0
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_dynamodb_instances_req_latency_history.id
    row      = 0
    column   = 3
    height   = 1
    width    = 9
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_dynamodb_instances_throttled.id
    row      = 1
    column   = 0
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_dynamodb_instances_throttled_history.id
    row      = 1
    column   = 3
    height   = 1
    width    = 9
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_dynamodb_instances_user_errors_history.id
    row      = 2
    column   = 0
    height   = 1
    width    = 9
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_dynamodb_instances_user_errors.id
    row      = 2
    column   = 9
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_dynamodb_instances_system_errors_history.id
    row      = 3
    column   = 0
    height   = 1
    width    = 9
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_dynamodb_instances_system_errors.id
    row      = 3
    column   = 9
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_dynamodb_instances_read_cap_pct.id
    row      = 4
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_dynamodb_instances_write_cap_pct.id
    row      = 4
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_dynamodb_instances_read_throttles.id
    row      = 5
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_dynamodb_instances_write_throttles.id
    row      = 5
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_dynamodb_instances_returned_items.id
    row      = 6
    column   = 0
    height   = 1
    width    = 12
  }
}
