resource "signalfx_single_value_chart" "sfx_aws_lambda_sfx_function_0" {
  color_by                = "Dimension"
  description             = "sum over 1m"
  is_timestamp_hidden     = false
  max_precision           = 0
  name                    = "Invocations"
  program_text            = "A = data('function.invocations', rollup='sum', extrapolation='zero').sum(over='1m').sum().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    color        = "green"
    display_name = "Invocations"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_sfx_function_1" {
  axes_include_zero         = false
  axes_precision            = 0
  color_by                  = "Dimension"
  description               = "The number of times a function is invoked in response to an event or invocation API call."
  disable_sampling          = false
  minimum_resolution        = 0
  name                      = "Invocations"
  on_chart_legend_dimension = "plot_label"
  plot_type                 = "AreaChart"
  program_text              = <<-EOF
        A = data('function.invocations', rollup='sum').sum().publish(label='A')
        B = data('function.errors', rollup='sum').sum().publish(label='B')
        C = data('function.coldStarts', rollup='sum').sum().publish(label='C')
    EOF
  show_data_markers         = false
  show_event_lines          = false
  stacked                   = false
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
  legend_options_fields {
    enabled  = false
    property = "aws_function_version"
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
    display_name = "Total Invocations"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    color        = "lilac"
    display_name = "Cold Starts"
    label        = "C"
  }
}

resource "signalfx_list_chart" "sfx_aws_lambda_sfx_function_2" {
  color_by                = "Dimension"
  description             = "The % of total invocations handled by version"
  disable_sampling        = false
  max_precision           = 0
  name                    = "% Invocations by Version"
  program_text            = <<-EOF
        A = data('function.invocations', rollup='sum', extrapolation='zero').sum().publish(label='A', enable=False)
        B = data('function.invocations', rollup='sum', extrapolation='zero').sum(by=['aws_function_version']).publish(label='B', enable=False)
        C = (B/A).scale(100).publish(label='C')
    EOF
  secondary_visualization = "None"
  sort_by                 = "-value"
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
  legend_options_fields {
    enabled  = true
    property = "aws_function_version"
  }

  viz_options {
    display_name = "% Handled"
    label        = "C"
  }
  viz_options {
    display_name = "Total Invocations"
    label        = "A"
  }
  viz_options {
    display_name = "function.invocations - Sum by aws_function_version"
    label        = "B"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_sfx_function_3" {
  axes_include_zero         = false
  axes_precision            = 0
  color_by                  = "Dimension"
  disable_sampling          = false
  minimum_resolution        = 0
  name                      = "Invocations by Version"
  on_chart_legend_dimension = "aws_function_version"
  plot_type                 = "AreaChart"
  program_text              = "A = data('function.invocations', rollup='sum').sum(by=['aws_function_version']).publish(label='A')"
  show_data_markers         = false
  show_event_lines          = false
  stacked                   = false
  time_range                = 900
  unit_prefix               = "Metric"

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    color        = "gray"
    display_name = "Invocations"
    label        = "A"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_lambda_sfx_function_4" {
  color_by                = "Dimension"
  description             = "sum over 1m"
  is_timestamp_hidden     = false
  max_precision           = 4
  name                    = "Errors"
  program_text            = "A = data('function.errors', rollup='sum', extrapolation='zero').sum(over='1m').sum().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    color        = "brown"
    display_name = "Errors"
    label        = "A"
  }
}

resource "signalfx_heatmap_chart" "sfx_aws_lambda_sfx_function_5" {
  description        = "% Erred Invocations"
  disable_sampling   = false
  group_by           = []
  hide_timestamp     = false
  minimum_resolution = 0
  name               = "Version Errors Heatmap"
  program_text       = <<-EOF
        A = data('function.invocations', rollup='sum', extrapolation='last_value', maxExtrapolations=2).sum(by=['aws_function_version']).publish(label='A', enable=False)
        B = data('function.errors', rollup='sum', extrapolation='last_value', maxExtrapolations=2).sum(by=['aws_function_version']).publish(label='B', enable=False)
        C = (B/A).scale(100).publish(label='C')
    EOF
  unit_prefix        = "Metric"

  color_scale {
    color = "green"
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

resource "signalfx_time_chart" "sfx_aws_lambda_sfx_function_6" {
  axes_include_zero         = false
  axes_precision            = 0
  color_by                  = "Dimension"
  disable_sampling          = false
  minimum_resolution        = 0
  name                      = "Errors by Version"
  on_chart_legend_dimension = "aws_function_version"
  plot_type                 = "AreaChart"
  program_text              = "A = data('function.errors', rollup='sum').sum(by=['aws_function_version']).publish(label='A')"
  show_data_markers         = false
  show_event_lines          = false
  stacked                   = true
  time_range                = 900
  unit_prefix               = "Metric"

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "Errors"
    label        = "A"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_lambda_sfx_function_7" {
  color_by                = "Metric"
  description             = "mean over 1m (ms)"
  is_timestamp_hidden     = false
  max_precision           = 0
  name                    = "Duration"
  program_text            = "A = data('function.duration', rollup='sum', extrapolation='zero').mean(over='1m').mean().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    color        = "azure"
    display_name = "Duration"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_sfx_function_8" {
  axes_include_zero         = false
  axes_precision            = 0
  color_by                  = "Dimension"
  description               = "percentile distribution"
  disable_sampling          = false
  minimum_resolution        = 0
  name                      = "Duration"
  plot_type                 = "AreaChart"
  program_text              = <<-EOF
        A = data('function.duration', rollup='average').mean().publish(label='A', enable=False)
        B = (A).max().publish(label='B')
        C = (A).min().publish(label='C')
        D = (A).percentile(pct=10).publish(label='D')
        E = (A).percentile(pct=50).publish(label='E')
        F = (A).percentile(pct=90).publish(label='F')
    EOF
  show_data_markers         = false
  show_event_lines          = false
  stacked                   = false
  time_range                = 900
  unit_prefix               = "Metric"

  axis_left {
    label = "ms"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis  = "left"
    label = "A"
  }
  viz_options {
    axis         = "left"
    display_name = "P50"
    label        = "E"
  }
  viz_options {
    axis         = "left"
    display_name = "P90"
    label        = "F"
  }
  viz_options {
    axis         = "left"
    color        = "azure"
    display_name = "P10"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    color        = "green"
    display_name = "Minimum"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    color        = "magenta"
    display_name = "Maximum"
    label        = "B"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_sfx_function_9" {
  axes_include_zero         = false
  axes_precision            = 0
  color_by                  = "Dimension"
  description               = "mean"
  disable_sampling          = false
  minimum_resolution        = 0
  name                      = "Duration by Version"
  on_chart_legend_dimension = "aws_function_version"
  plot_type                 = "AreaChart"
  program_text              = <<-EOF
        A = data('function.duration', rollup='sum').sum(by=['aws_function_version']).publish(label='A', enable=False)
        B = data('function.invocations', rollup='sum').sum(by=['aws_function_version']).publish(label='B', enable=False)
        C = (A/B).publish(label='C')
    EOF
  show_data_markers         = false
  show_event_lines          = false
  stacked                   = false
  time_range                = 900
  unit_prefix               = "Metric"

  axis_left {
    label = "ms"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "Average Duration"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    display_name = "P95"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    display_name = "function.invocations - Sum by aws_function_version"
    label        = "B"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_lambda_sfx_function_10" {
  color_by                = "Dimension"
  description             = "sum over 1m"
  is_timestamp_hidden     = false
  max_precision           = 4
  name                    = "Cold Starts"
  program_text            = "A = data('function.cold_starts', rollup='sum', extrapolation='zero').sum(over='1m').sum().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    color        = "lilac"
    display_name = "Cold Starts"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_sfx_function_11" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Cold Starts by Version"
  plot_type          = "ColumnChart"
  program_text       = "A = data('function.cold_starts', rollup='sum').sum(by=['aws_function_version']).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 900
  unit_prefix        = "Metric"

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    color        = "blue"
    display_name = "Cold Starts"
    label        = "A"
  }
}

resource "signalfx_dashboard" "sfx_aws_lambda_sfx_function" {

  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.sfx_aws_lambda.id
  name              = "Lambda (SignalFx) Function"

  variable {
    alias                  = "Function Name"
    apply_if_exist         = false
    property               = "aws_function_name"
    replace_only           = false
    restricted_suggestions = false
    value_required         = true
    values = [
      "Choose a function",
    ]
    values_suggested = []
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_lambda_sfx_function_0.id
    row      = 0
    column   = 0
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_sfx_function_1.id
    row      = 0
    column   = 3
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_lambda_sfx_function_2.id
    row      = 0
    column   = 6
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_sfx_function_3.id
    row      = 0
    column   = 9
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_lambda_sfx_function_4.id
    row      = 1
    column   = 0
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_heatmap_chart.sfx_aws_lambda_sfx_function_5.id
    row      = 1
    column   = 3
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_sfx_function_6.id
    row      = 1
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_lambda_sfx_function_7.id
    row      = 2
    column   = 0
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_sfx_function_8.id
    row      = 2
    column   = 3
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_sfx_function_9.id
    row      = 2
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_lambda_sfx_function_10.id
    row      = 3
    column   = 0
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_sfx_function_11.id
    row      = 3
    column   = 3
    height   = 1
    width    = 9
  }

}
