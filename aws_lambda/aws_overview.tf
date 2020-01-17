resource "signalfx_single_value_chart" "sfx_aws_lambda_aws_overview_0" {
  color_by                = "Dimension"
  description             = "last 5m, including different function versions"
  is_timestamp_hidden     = false
  max_precision           = 0
  name                    = "Active Functions"
  program_text            = "A = data('Duration', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'count') and filter('Resource', '*'), rollup='count', extrapolation='zero').count(by=['Resource']).count().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "Active Function Count"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_aws_overview_1" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "last 5m, including different function versions | depends on metadata synchronization to acquire account id"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Active Functions by AWS Account"
  plot_type          = "AreaChart"
  program_text       = "A = data('Duration', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'count') and filter('Resource', '*') and filter('FunctionName', '*'), rollup='rate', extrapolation='zero').sum(by=['FunctionName', 'Resource']).sum(over='5m').count(by=['aws_account_id']).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = true
  time_range         = 3600
  unit_prefix        = "Metric"

  histogram_options {
    color_theme = "red"
  }

  legend_options_fields {
    enabled  = true
    property = "aws_account_id"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_originatingMetric"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_metric"
  }

  viz_options {
    axis         = "left"
    display_name = "Active Function Count"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_aws_overview_2" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "last 5m, including different function versions | depends on metadata synchronization to acquire aws region"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Active Functions by AWS Region"
  plot_type          = "AreaChart"
  program_text       = "A = data('Duration', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'count') and filter('Resource', '*') and filter('FunctionName', '*'), rollup='rate', extrapolation='zero').sum(by=['FunctionName', 'Resource']).sum(over='5m').count(by=['aws_region']).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = true
  time_range         = 3600
  unit_prefix        = "Metric"

  histogram_options {
    color_theme = "red"
  }

  legend_options_fields {
    enabled  = false
    property = "aws_account_id"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_originatingMetric"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_metric"
  }
  legend_options_fields {
    enabled  = true
    property = "aws_region"
  }
  legend_options_fields {
    enabled  = true
    property = "FunctionName"
  }
  legend_options_fields {
    enabled  = true
    property = "Resource"
  }

  viz_options {
    axis         = "left"
    display_name = "Active Function Count"
    label        = "A"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_lambda_aws_overview_3" {
  color_by                = "Dimension"
  description             = "over last 5m"
  is_timestamp_hidden     = false
  max_precision           = 0
  name                    = "Total Invocations"
  program_text            = "A = data('Invocations', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'sum') and filter('Resource', '*') and (not filter('ExecutedVersion', '*')), rollup='sum', extrapolation='zero').sum(over='5m').sum().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    color        = "green"
    display_name = "Invocations - Sum(5m) - Sum"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_aws_overview_4" {
  axes_include_zero         = false
  axes_precision            = 0
  color_by                  = "Dimension"
  description               = "The number of times a function reported an invocation, error, or throttle"
  disable_sampling          = false
  minimum_resolution        = 0
  name                      = "Invocations | Errors | Throttles"
  on_chart_legend_dimension = "plot_label"
  plot_type                 = "AreaChart"
  program_text              = <<-EOF
        A = data('Invocations', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'sum') and filter('Resource', '*') and (not filter('ExecutedVersion', '*')), rollup='sum').sum().publish(label='A')
        B = data('Errors', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'sum') and filter('Resource', '*') and (not filter('ExecutedVersion', '*')), rollup='sum').sum().publish(label='B')
        C = data('Throttles', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'sum') and filter('Resource', '*') and (not filter('ExecutedVersion', '*')), rollup='sum').sum().publish(label='C')
    EOF
  show_data_markers         = false
  show_event_lines          = false
  stacked                   = false
  time_range                = 3600
  unit_prefix               = "Metric"

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    color        = "brown"
    display_name = "Errors"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    color        = "green"
    display_name = "Invocations"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    color        = "yellow"
    display_name = "Throttles"
    label        = "C"
  }
}

resource "signalfx_list_chart" "sfx_aws_lambda_aws_overview_5" {
  color_by                = "Dimension"
  description             = "sum over 5m"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Invocations by function"
  program_text            = "A = data('Invocations', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'sum') and filter('Resource', '*') and (not filter('ExecutedVersion', '*')), rollup='sum', extrapolation='zero').sum(over='5m').sum(by=['FunctionName']).publish(label='A')"
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  time_range              = 900
  unit_prefix             = "Metric"

  legend_options_fields {
    enabled  = false
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = true
    property = "FunctionName"
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
    property = "Resource"
  }
  legend_options_fields {
    enabled  = false
    property = "stat"
  }

  viz_options {
    display_name = "Invocations - Sum(5m) - Sum by FunctionName"
    label        = "A"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_lambda_aws_overview_6" {
  color_by                = "Dimension"
  description             = "over last 5m"
  is_timestamp_hidden     = false
  max_precision           = 0
  name                    = "Total Errors"
  program_text            = "A = data('Errors', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'sum') and filter('Resource', '*') and (not filter('ExecutedVersion', '*')), rollup='sum', extrapolation='zero').sum(over='5m').sum().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    color        = "brown"
    display_name = "Errors - Sum(5m) - Sum"
    label        = "A"
  }
}

resource "signalfx_heatmap_chart" "sfx_aws_lambda_aws_overview_7" {
  description        = "% of invocations with errors (5m)"
  disable_sampling   = false
  group_by           = []
  hide_timestamp     = false
  minimum_resolution = 0
  name               = "Error Heatmap by Function"
  program_text       = <<-EOF
        A = data('Errors', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'sum') and filter('Resource', '*') and (not filter('ExecutedVersion', '*')), rollup='sum', extrapolation='last_value', maxExtrapolations=2).sum(over='5m').sum(by=['FunctionName']).publish(label='A', enable=False)
        B = data('Invocations', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'sum') and filter('Resource', '*') and (not filter('ExecutedVersion', '*')), rollup='sum', extrapolation='last_value', maxExtrapolations=2).sum(over='5m').sum(by=['FunctionName']).publish(label='B', enable=False)
        C = (A/B).scale(100).publish(label='C')
    EOF
  sort_by            = "-value"
  unit_prefix        = "Metric"

  color_scale {
    color = "lime_green"
    gt    = 340282346638528860000000000000000000000
    gte   = 340282346638528860000000000000000000000
    lt    = 340282346638528860000000000000000000000
    lte   = 0
  }
  color_scale {
    color = "red"
    gt    = 20
    gte   = 340282346638528860000000000000000000000
    lt    = 340282346638528860000000000000000000000
    lte   = 340282346638528860000000000000000000000
  }
  color_scale {
    color = "vivid_yellow"
    gt    = 0
    gte   = 340282346638528860000000000000000000000
    lt    = 340282346638528860000000000000000000000
    lte   = 5
  }
  color_scale {
    color = "yellow"
    gt    = 5
    gte   = 340282346638528860000000000000000000000
    lt    = 340282346638528860000000000000000000000
    lte   = 20
  }
}

resource "signalfx_list_chart" "sfx_aws_lambda_aws_overview_8" {
  color_by                = "Dimension"
  description             = "over 5m"
  disable_sampling        = false
  max_precision           = 0
  name                    = "% of total errors by function"
  program_text            = <<-EOF
        B = data('Errors', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'sum') and filter('Resource', '*') and (not filter('ExecutedVersion', '*')), rollup='sum', extrapolation='zero').sum(over='5m').sum().publish(label='B', enable=False)
        A = data('Errors', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'sum') and filter('Resource', '*') and (not filter('ExecutedVersion', '*')), rollup='sum', extrapolation='zero').sum(over='5m').sum(by=['FunctionName']).publish(label='A', enable=False)
        C = (A/B).scale(100).publish(label='C')
    EOF
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  time_range              = 900
  unit_prefix             = "Metric"

  legend_options_fields {
    enabled  = false
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = true
    property = "FunctionName"
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
    property = "Resource"
  }
  legend_options_fields {
    enabled  = false
    property = "stat"
  }

  viz_options {
    display_name = "A/B - Scale:100"
    label        = "C"
    value_suffix = "%"
  }
  viz_options {
    display_name = "Errors - Sum(5m) - Sum by FunctionName"
    label        = "A"
  }
  viz_options {
    display_name = "Total Errors"
    label        = "B"
  }
}

resource "signalfx_list_chart" "sfx_aws_lambda_aws_overview_9" {
  color_by                = "Dimension"
  description             = "sum over 5m"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Errors by Function"
  program_text            = "A = data('Errors', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'sum') and filter('Resource', '*'), rollup='sum', extrapolation='zero').sum(over='5m').sum(by=['FunctionName']).publish(label='A')"
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  time_range              = 900
  unit_prefix             = "Metric"

  legend_options_fields {
    enabled  = false
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = true
    property = "FunctionName"
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
    property = "Resource"
  }
  legend_options_fields {
    enabled  = false
    property = "stat"
  }

  viz_options {
    display_name = "Errors - Sum(5m) - Sum by FunctionName"
    label        = "A"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_lambda_aws_overview_10" {
  color_by                = "Dimension"
  is_timestamp_hidden     = false
  max_precision           = 0
  name                    = "Average Duration of All Functions"
  program_text            = "A = data('Duration', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'mean') and filter('Resource', '*') and (not filter('ExecutedVersion', '*')), rollup='average').mean().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "Duration - Mean"
    label        = "A"
    value_unit   = "Millisecond"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_aws_overview_11" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "The elapsed wall clock time from when the function code starts executing as a result of an invocation to when it stops executing."
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Average Duration per Function"
  plot_type          = "LineChart"
  program_text       = "A = data('Duration', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'mean') and filter('Resource', '*') and (not filter('ExecutedVersion', '*')), rollup='sum').mean(by=['FunctionName']).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 3600
  unit_prefix        = "Metric"

  axis_left {
    label = "ms"
  }

  histogram_options {
    color_theme = "red"
  }

  legend_options_fields {
    enabled  = false
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = true
    property = "FunctionName"
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
    property = "Resource"
  }
  legend_options_fields {
    enabled  = false
    property = "stat"
  }

  viz_options {
    axis         = "left"
    display_name = "average duration"
    label        = "A"
    value_unit   = "Millisecond"
  }
}

resource "signalfx_list_chart" "sfx_aws_lambda_aws_overview_12" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Average Duration by Function"
  program_text            = "A = data('Duration', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'mean') and filter('Resource', '*') and (not filter('ExecutedVersion', '*')), rollup='average').sum(by=['FunctionName']).publish(label='A')"
  refresh_interval        = 3600
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  time_range              = 900
  unit_prefix             = "Metric"

  legend_options_fields {
    enabled  = true
    property = "FunctionName"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_originatingMetric"
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
    enabled  = false
    property = "namespace"
  }
  legend_options_fields {
    enabled  = false
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = false
    property = "Resource"
  }

  viz_options {
    display_name = "Execution time"
    label        = "A"
    value_unit   = "Millisecond"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_lambda_aws_overview_13" {
  color_by                = "Dimension"
  description             = "over last 5m"
  is_timestamp_hidden     = false
  max_precision           = 0
  name                    = "Total Throttles"
  program_text            = "A = data('Throttles', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'sum') and filter('Resource', '*') and (not filter('ExecutedVersion', '*')), rollup='sum', extrapolation='zero').sum(over='5m').sum().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    color        = "yellow"
    display_name = "Throttles - Sum(5m) - Sum"
    label        = "A"
  }
}

resource "signalfx_heatmap_chart" "sfx_aws_lambda_aws_overview_14" {
  description        = "% of Invocations throttled | 0% -5% Yellow, 5% - 20% Orange, >20% Red"
  disable_sampling   = false
  group_by           = []
  hide_timestamp     = false
  minimum_resolution = 0
  name               = "Throttle Heatmap"
  program_text       = <<-EOF
        A = data('Throttles', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'sum') and filter('Resource', '*') and (not filter('ExecutedVersion', '*')), rollup='sum').sum(over='5m').sum(by=['FunctionName']).publish(label='A', enable=False)
        B = data('Invocations', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'sum') and filter('Resource', '*') and (not filter('ExecutedVersion', '*')), rollup='sum').sum(over='5m').sum(by=['FunctionName']).publish(label='B', enable=False)
        C = (A/B).scale(100).publish(label='C')
    EOF
  unit_prefix        = "Metric"

  color_scale {
    color = "lime_green"
    gt    = 340282346638528860000000000000000000000
    gte   = 340282346638528860000000000000000000000
    lt    = 340282346638528860000000000000000000000
    lte   = 0
  }
  color_scale {
    color = "red"
    gt    = 20
    gte   = 340282346638528860000000000000000000000
    lt    = 340282346638528860000000000000000000000
    lte   = 340282346638528860000000000000000000000
  }
  color_scale {
    color = "vivid_yellow"
    gt    = 0
    gte   = 340282346638528860000000000000000000000
    lt    = 340282346638528860000000000000000000000
    lte   = 5
  }
  color_scale {
    color = "yellow"
    gt    = 5
    gte   = 340282346638528860000000000000000000000
    lt    = 340282346638528860000000000000000000000
    lte   = 20
  }
}

resource "signalfx_list_chart" "sfx_aws_lambda_aws_overview_15" {
  color_by                = "Dimension"
  description             = "over 5m"
  disable_sampling        = false
  max_precision           = 0
  name                    = "% of total throttles by function"
  program_text            = <<-EOF
        A = data('Throttles', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'sum') and filter('Resource', '*'), rollup='sum', extrapolation='zero').sum(over='5m').sum().publish(label='A', enable=False)
        B = data('Throttles', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'sum') and filter('Resource', '*'), rollup='sum', extrapolation='zero').sum(over='5m').sum(by=['FunctionName']).publish(label='B', enable=False)
        C = (B/A).scale(100).publish(label='C')
    EOF
  secondary_visualization = "None"
  sort_by                 = "-value"
  time_range              = 900
  unit_prefix             = "Metric"

  legend_options_fields {
    enabled  = false
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = true
    property = "FunctionName"
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
    property = "Resource"
  }
  legend_options_fields {
    enabled  = false
    property = "stat"
  }

  viz_options {
    display_name = "% of total"
    label        = "C"
    value_suffix = "%"
  }
  viz_options {
    display_name = "Throttles - Sum(5m) - Sum by FunctionName"
    label        = "B"
  }
  viz_options {
    display_name = "Total Throttles"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_lambda_aws_overview_16" {
  color_by                = "Dimension"
  description             = "sum over 5m"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Throttles by function"
  program_text            = "A = data('Throttles', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'sum') and filter('Resource', '*') and (not filter('ExecutedVersion', '*')), rollup='sum', extrapolation='zero').sum(over='5m').sum(by=['FunctionName']).publish(label='A')"
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  time_range              = 900
  unit_prefix             = "Metric"

  legend_options_fields {
    enabled  = false
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = true
    property = "FunctionName"
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
    property = "Resource"
  }
  legend_options_fields {
    enabled  = false
    property = "stat"
  }

  viz_options {
    display_name = "Throttles - Sum(5m) - Sum by FunctionName"
    label        = "A"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_lambda_aws_overview_17" {
  color_by                = "Dimension"
  description             = "over 5m | Spillover invocations are run on nonprovisioned concurrency, when all provisioned concurrency is in use."
  is_timestamp_hidden     = false
  max_delay               = 0
  max_precision           = 0
  name                    = "Total Spillover Invocations"
  program_text            = "A = data('ProvisionedConcurrencySpilloverInvocations', filter=filter('stat', 'sum') and filter('Resource', '*') and filter('ExecutedVersion', '*')).sum(over='5m').sum().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "Provisioned Concurrent Invocations"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_aws_overview_18" {
  axes_include_zero         = false
  axes_precision            = 0
  color_by                  = "Dimension"
  description               = "The number of invocations that are run on nonprovisioned concurrency, when all provisioned concurrency is in use. For a version or alias that is configured to use provisioned concurrency, Lambda increments the count once for each invocation that runs on non-provisioned concurrency."
  disable_sampling          = false
  max_delay                 = 0
  minimum_resolution        = 0
  name                      = "Provisioned Concurrency Spillover Invocations by Function"
  on_chart_legend_dimension = "ExecutedVersion"
  plot_type                 = "AreaChart"
  program_text              = "A = data('ProvisionedConcurrencySpilloverInvocations', filter=filter('stat', 'sum') and filter('Resource', '*') and (not filter('ExecutedVersion', '*'))).sum(by=['FunctionName']).publish(label='A')"
  show_data_markers         = false
  show_event_lines          = false
  stacked                   = true
  time_range                = 900
  unit_prefix               = "Metric"

  histogram_options {
    color_theme = "red"
  }

  legend_options_fields {
    enabled  = false
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = true
    property = "ExecutedVersion"
  }
  legend_options_fields {
    enabled  = true
    property = "FunctionName"
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
    property = "Resource"
  }
  legend_options_fields {
    enabled  = false
    property = "stat"
  }

  viz_options {
    axis         = "left"
    display_name = "Provisioned Concurrent Invocations"
    label        = "A"
  }
}

resource "signalfx_dashboard" "sfx_aws_lambda_aws_overview" {

  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.sfx_aws_lambda.id
  name              = "Lambda (AWS) Overview"

  variable {
    alias                  = "AWS Account ID"
    apply_if_exist         = false
    property               = "aws_account_id"
    replace_only           = false
    restricted_suggestions = false
    value_required         = false
    values                 = []
    values_suggested       = []
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_lambda_aws_overview_0.id
    row      = 0
    column   = 0
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_aws_overview_1.id
    row      = 0
    column   = 3
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_aws_overview_2.id
    row      = 0
    column   = 9
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_lambda_aws_overview_3.id
    row      = 1
    column   = 0
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_aws_overview_4.id
    row      = 1
    column   = 3
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_lambda_aws_overview_5.id
    row      = 1
    column   = 9
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_lambda_aws_overview_6.id
    row      = 2
    column   = 0
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_heatmap_chart.sfx_aws_lambda_aws_overview_7.id
    row      = 2
    column   = 3
    height   = 2
    width    = 6
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_lambda_aws_overview_8.id
    row      = 2
    column   = 9
    height   = 2
    width    = 3
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_lambda_aws_overview_9.id
    row      = 3
    column   = 0
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_lambda_aws_overview_10.id
    row      = 4
    column   = 0
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_aws_overview_11.id
    row      = 4
    column   = 3
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_lambda_aws_overview_12.id
    row      = 4
    column   = 9
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_lambda_aws_overview_13.id
    row      = 5
    column   = 0
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_heatmap_chart.sfx_aws_lambda_aws_overview_14.id
    row      = 5
    column   = 3
    height   = 2
    width    = 6
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_lambda_aws_overview_15.id
    row      = 5
    column   = 9
    height   = 2
    width    = 3
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_lambda_aws_overview_16.id
    row      = 6
    column   = 0
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_lambda_aws_overview_17.id
    row      = 7
    column   = 0
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_aws_overview_18.id
    row      = 7
    column   = 3
    height   = 1
    width    = 6
  }

}
