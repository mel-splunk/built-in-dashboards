resource "signalfx_single_value_chart" "sfx_aws_kinesis_analytics_overview_0" {
  color_by                = "Dimension"
  is_timestamp_hidden     = false
  max_delay               = 0
  max_precision           = 0
  name                    = "Active Applications"
  program_text            = "A = data('Bytes', filter=filter('namespace', 'AWS/KinesisAnalytics') and filter('stat', 'mean')).sum(by=['Application']).count().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "Active Applications"
    label        = "A"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_kinesis_analytics_overview_1" {
  color_by                = "Dimension"
  is_timestamp_hidden     = false
  max_delay               = 0
  max_precision           = 0
  name                    = "Successful Deliveries"
  program_text            = "A = data('Success', filter=filter('namespace', 'AWS/KinesisAnalytics') and filter('stat', 'sum'), rollup='sum').sum().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "Success - Sum"
    label        = "A"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_kinesis_analytics_overview_2" {
  color_by                = "Scale"
  is_timestamp_hidden     = false
  max_delay               = 0
  max_precision           = 0
  name                    = "Lambda Delivery Success Rate"
  program_text            = <<-EOF
        A = data('LambdaDelivery.OkRecords', filter=filter('namespace', 'AWS/KinesisAnalytics') and filter('stat', 'sum'), rollup='sum').sum().publish(label='A', enable=False)
        B = data('LambdaDelivery.DeliveryFailedRecords', filter=filter('namespace', 'AWS/KinesisAnalytics') and filter('stat', 'sum'), rollup='sum').sum().publish(label='B', enable=False)
        C = (A/(A+B)*100).publish(label='C')
    EOF
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  color_scale {
    color = "light_green"
    gt    = 90
    gte   = 340282346638528860000000000000000000000
    lt    = 340282346638528860000000000000000000000
    lte   = 95
  }
  color_scale {
    color = "lime_green"
    gt    = 95
    gte   = 340282346638528860000000000000000000000
    lt    = 340282346638528860000000000000000000000
    lte   = 340282346638528860000000000000000000000
  }
  color_scale {
    color = "red"
    gt    = 340282346638528860000000000000000000000
    gte   = 340282346638528860000000000000000000000
    lt    = 340282346638528860000000000000000000000
    lte   = 80
  }
  color_scale {
    color = "vivid_yellow"
    gt    = 85
    gte   = 340282346638528860000000000000000000000
    lt    = 340282346638528860000000000000000000000
    lte   = 90
  }
  color_scale {
    color = "yellow"
    gt    = 80
    gte   = 340282346638528860000000000000000000000
    lt    = 340282346638528860000000000000000000000
    lte   = 85
  }

  viz_options {
    display_name = "A/(A+B)*100"
    label        = "C"
    value_suffix = "%"
  }
  viz_options {
    display_name = "LambdaDelivery.DeliveryFailedRecords - Sum"
    label        = "B"
  }
  viz_options {
    display_name = "LambdaDelivery.OkRecords - Sum"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_kinesis_analytics_overview_3" {
  color_by                = "Dimension"
  description             = "The time taken for each AWS Lambda function invocation performed by Kinesis Data Analytics"
  disable_sampling        = false
  max_delay               = 0
  max_precision           = 0
  name                    = "5 Shortest Processing Durations"
  program_text            = "A = data('InputProcessing.Duration', filter=filter('namespace', 'AWS/KinesisAnalytics') and filter('stat', 'mean')).mean(by=['Application', 'AWSUniqueId']).bottom(count=5).publish(label='A')"
  secondary_visualization = "None"
  sort_by                 = "-value"
  time_range              = 900
  unit_prefix             = "Metric"

  legend_options_fields {
    enabled  = true
    property = "Application"
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
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = true
    property = "aws_region"
  }

  viz_options {
    display_name = "Input Processing Duration"
    label        = "A"
    value_unit   = "Millisecond"
  }
}

resource "signalfx_list_chart" "sfx_aws_kinesis_analytics_overview_4" {
  color_by                = "Dimension"
  description             = "The time taken for each AWS Lambda function invocation performed by Kinesis Data Analytics"
  disable_sampling        = false
  max_delay               = 0
  max_precision           = 0
  name                    = "5 Longest Processing Durations"
  program_text            = "A = data('InputProcessing.Duration', filter=filter('namespace', 'AWS/KinesisAnalytics') and filter('stat', 'mean')).mean(by=['Application', 'AWSUniqueId']).top(count=5).publish(label='A')"
  secondary_visualization = "None"
  sort_by                 = "-value"
  time_range              = 900
  unit_prefix             = "Metric"

  legend_options_fields {
    enabled  = true
    property = "Application"
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
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = true
    property = "aws_region"
  }

  viz_options {
    display_name = "Input Processing Duration"
    label        = "A"
    value_unit   = "Millisecond"
  }
}

resource "signalfx_list_chart" "sfx_aws_kinesis_analytics_overview_5" {
  color_by                = "Dimension"
  description             = "The time taken for each Lambda function invocation performed by Kinesis Data Analytics"
  disable_sampling        = false
  max_delay               = 0
  max_precision           = 0
  name                    = "5 Shortest Lambda Delivery Durations"
  program_text            = "A = data('LambdaDelivery.Duration', filter=filter('namespace', 'AWS/KinesisAnalytics') and filter('stat', 'mean')).mean(by=['Application', 'AWSUniqueId']).bottom(count=5).publish(label='A')"
  secondary_visualization = "None"
  time_range              = 900
  unit_prefix             = "Metric"

  legend_options_fields {
    enabled  = true
    property = "Application"
  }
  legend_options_fields {
    enabled  = true
    property = "AWSUniqueId"
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
    display_name = "LambdaDelivery.Duration - Mean by Application,AWSUniqueId - Bottom 5"
    label        = "A"
    value_unit   = "Millisecond"
  }
}

resource "signalfx_list_chart" "sfx_aws_kinesis_analytics_overview_6" {
  color_by                = "Dimension"
  description             = "The time taken for each Lambda function invocation performed by Kinesis Data Analytics"
  disable_sampling        = false
  max_delay               = 0
  max_precision           = 0
  name                    = "5 Longest Lambda Delivery Durations"
  program_text            = "A = data('LambdaDelivery.Duration', filter=filter('namespace', 'AWS/KinesisAnalytics') and filter('stat', 'mean')).mean(by=['Application', 'AWSUniqueId']).top(count=5).publish(label='A')"
  secondary_visualization = "None"
  time_range              = 900
  unit_prefix             = "Metric"

  legend_options_fields {
    enabled  = true
    property = "Application"
  }
  legend_options_fields {
    enabled  = true
    property = "AWSUniqueId"
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
    display_name = "LambdaDelivery.Duration - Mean by Application,AWSUniqueId - Top 5"
    label        = "A"
    value_unit   = "Millisecond"
  }
}

resource "signalfx_time_chart" "sfx_aws_kinesis_analytics_overview_7" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  max_delay          = 0
  minimum_resolution = 0
  name               = "Received Bytes/Records Trend"
  plot_type          = "ColumnChart"
  program_text       = <<-EOF
        B = data('Bytes', filter=filter('namespace', 'AWS/KinesisAnalytics') and filter('Flow', 'Input') and filter('stat', 'sum'), rollup='sum').sum().publish(label='B')
        A = data('Records', filter=filter('namespace', 'AWS/KinesisAnalytics') and filter('Flow', 'Input') and filter('stat', 'sum'), rollup='sum').sum().publish(label='A')
    EOF
  show_data_markers  = true
  show_event_lines   = false
  stacked            = false
  time_range         = 900
  unit_prefix        = "Metric"

  axis_left {
    label = "bytes"
  }

  axis_right {
    label = "records"
  }

  histogram_options {
    color_theme = "red"
  }

  legend_options_fields {
    enabled  = true
    property = "Application"
  }
  legend_options_fields {
    enabled  = true
    property = "Id"
  }
  legend_options_fields {
    enabled  = true
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = false
    property = "Flow"
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

  viz_options {
    axis         = "left"
    color        = "yellow"
    display_name = "Bytes - Sum"
    label        = "B"
    plot_type    = "ColumnChart"
    value_unit   = "Byte"
  }
  viz_options {
    axis         = "right"
    color        = "blue"
    display_name = "Records - Sum"
    label        = "A"
    plot_type    = "LineChart"
    value_suffix = "records"
  }
}

resource "signalfx_time_chart" "sfx_aws_kinesis_analytics_overview_8" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  max_delay          = 0
  minimum_resolution = 0
  name               = "Sent Bytes/Records Trend"
  plot_type          = "ColumnChart"
  program_text       = <<-EOF
        B = data('Bytes', filter=filter('namespace', 'AWS/KinesisAnalytics') and filter('Flow', 'Output') and filter('stat', 'sum'), rollup='sum').sum().publish(label='B')
        A = data('Records', filter=filter('namespace', 'AWS/KinesisAnalytics') and filter('Flow', 'Output') and filter('stat', 'sum'), rollup='sum').sum().publish(label='A')
    EOF
  show_data_markers  = true
  show_event_lines   = false
  stacked            = false
  time_range         = 900
  unit_prefix        = "Metric"

  axis_left {
    label = "bytes"
  }

  axis_right {
    label = "records"
  }

  histogram_options {
    color_theme = "red"
  }

  legend_options_fields {
    enabled  = true
    property = "Application"
  }
  legend_options_fields {
    enabled  = true
    property = "Id"
  }
  legend_options_fields {
    enabled  = true
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = false
    property = "Flow"
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

  viz_options {
    axis         = "left"
    color        = "yellow"
    display_name = "Bytes - Sum"
    label        = "B"
    plot_type    = "ColumnChart"
    value_unit   = "Byte"
  }
  viz_options {
    axis         = "right"
    color        = "blue"
    display_name = "Records - Sum"
    label        = "A"
    plot_type    = "LineChart"
    value_suffix = "records"
  }
}

resource "signalfx_time_chart" "sfx_aws_kinesis_analytics_overview_9" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "# of records read"
  disable_sampling   = false
  max_delay          = 0
  minimum_resolution = 0
  name               = "Records Received per Application"
  plot_type          = "LineChart"
  program_text       = "A = data('Records', filter=filter('namespace', 'AWS/KinesisAnalytics') and filter('Flow', 'Input') and filter('stat', 'sum'), rollup='sum').mean(by=['AWSUniqueId', 'Application']).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 900
  unit_prefix        = "Metric"

  histogram_options {
    color_theme = "red"
  }

  legend_options_fields {
    enabled  = true
    property = "Application"
  }
  legend_options_fields {
    enabled  = true
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = false
    property = "Id"
  }
  legend_options_fields {
    enabled  = false
    property = "Flow"
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

  viz_options {
    axis         = "left"
    display_name = "Records Received"
    label        = "A"
    value_suffix = "records"
  }
}

resource "signalfx_time_chart" "sfx_aws_kinesis_analytics_overview_10" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "# of bytes read"
  disable_sampling   = false
  max_delay          = 0
  minimum_resolution = 0
  name               = "Bytes Received per Application"
  plot_type          = "LineChart"
  program_text       = "A = data('Bytes', filter=filter('namespace', 'AWS/KinesisAnalytics') and filter('Flow', 'Input') and filter('stat', 'sum'), rollup='sum').mean(by=['AWSUniqueId', 'Application']).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 900
  unit_prefix        = "Metric"

  histogram_options {
    color_theme = "red"
  }

  legend_options_fields {
    enabled  = true
    property = "Application"
  }
  legend_options_fields {
    enabled  = true
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = false
    property = "Id"
  }
  legend_options_fields {
    enabled  = false
    property = "Flow"
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

  viz_options {
    axis         = "left"
    display_name = "Bytes Received"
    label        = "A"
    value_unit   = "Byte"
  }
}

resource "signalfx_time_chart" "sfx_aws_kinesis_analytics_overview_11" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "# of bytes written"
  disable_sampling   = false
  max_delay          = 0
  minimum_resolution = 0
  name               = "Bytes Sent per Application"
  plot_type          = "LineChart"
  program_text       = "A = data('Bytes', filter=filter('namespace', 'AWS/KinesisAnalytics') and filter('Flow', 'Output') and filter('stat', 'sum'), rollup='sum').mean(by=['AWSUniqueId', 'Application']).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 900
  unit_prefix        = "Metric"

  histogram_options {
    color_theme = "red"
  }

  legend_options_fields {
    enabled  = true
    property = "Application"
  }
  legend_options_fields {
    enabled  = true
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = false
    property = "Id"
  }
  legend_options_fields {
    enabled  = false
    property = "Flow"
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

  viz_options {
    axis         = "left"
    display_name = "Bytes Sent"
    label        = "A"
    value_unit   = "Byte"
  }
}

resource "signalfx_time_chart" "sfx_aws_kinesis_analytics_overview_12" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "# of records written"
  disable_sampling   = false
  max_delay          = 0
  minimum_resolution = 0
  name               = "Records Sent per Application"
  plot_type          = "LineChart"
  program_text       = "A = data('Records', filter=filter('namespace', 'AWS/KinesisAnalytics') and filter('Flow', 'Output') and filter('stat', 'sum'), rollup='sum').mean(by=['AWSUniqueId', 'Application']).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 900
  unit_prefix        = "Metric"

  histogram_options {
    color_theme = "red"
  }

  legend_options_fields {
    enabled  = true
    property = "Application"
  }
  legend_options_fields {
    enabled  = true
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = false
    property = "Id"
  }
  legend_options_fields {
    enabled  = false
    property = "Flow"
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

  viz_options {
    axis         = "left"
    display_name = "Records Sent"
    label        = "A"
    value_suffix = "records"
  }
}

resource "signalfx_time_chart" "sfx_aws_kinesis_analytics_overview_13" {
  axes_include_zero         = true
  axes_precision            = 0
  color_by                  = "Metric"
  description               = "% vs 24 hrs ago"
  disable_sampling          = false
  max_delay                 = 0
  minimum_resolution        = 0
  name                      = "% Change in Received Records"
  on_chart_legend_dimension = "plot_label"
  plot_type                 = "LineChart"
  program_text              = <<-EOF
        A = data('Records', filter=filter('namespace', 'AWS/KinesisAnalytics') and filter('stat', 'sum') and filter('Flow', 'Input'), rollup='sum').sum().publish(label='A', enable=False)
        B = data('Records', filter=filter('namespace', 'AWS/KinesisAnalytics') and filter('stat', 'sum') and filter('Flow', 'Input'), rollup='sum').sum().timeshift('1d').publish(label='B', enable=False)
        C = ((A-B)/B*100).publish(label='C')
    EOF
  show_data_markers         = false
  show_event_lines          = false
  stacked                   = false
  time_range                = 900
  unit_prefix               = "Metric"

  axis_left {
    label               = "% change"
    low_watermark       = 0.0000009999999974752427
    low_watermark_label = "0%"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "-1d"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "Today"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    color        = "blue"
    display_name = "% change"
    label        = "C"
    value_suffix = "%"
  }
}

resource "signalfx_time_chart" "sfx_aws_kinesis_analytics_overview_14" {
  axes_include_zero         = false
  axes_precision            = 0
  color_by                  = "Dimension"
  description               = "5m / 1h / 24h"
  disable_sampling          = false
  max_delay                 = 0
  minimum_resolution        = 0
  name                      = "Record Received in the Past"
  on_chart_legend_dimension = "plot_label"
  plot_type                 = "AreaChart"
  program_text              = <<-EOF
        A = data('Records', filter=filter('namespace', 'AWS/KinesisAnalytics') and filter('Flow', 'Input') and filter('stat', 'sum'), rollup='sum').sum().publish(label='A', enable=False)
        G = (A).sum(over='5m').publish(label='G')
        H = (A).sum(over='1h').publish(label='H')
        I = (A).sum(over='24h').publish(label='I')
    EOF
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
    display_name = "Records - Sum"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    color        = "aquamarine"
    display_name = "24h"
    label        = "I"
    value_suffix = "records"
  }
  viz_options {
    axis         = "left"
    color        = "blue"
    display_name = "5m"
    label        = "G"
    value_suffix = "records"
  }
  viz_options {
    axis         = "left"
    color        = "pink"
    display_name = "1h"
    label        = "H"
    value_suffix = "records"
  }
}

resource "signalfx_time_chart" "sfx_aws_kinesis_analytics_overview_15" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "5m / 1h / 24h"
  disable_sampling   = false
  max_delay          = 0
  minimum_resolution = 0
  name               = "Input Processing Failed + Dropped Records in the Past"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('InputProcessing.ProcessingFailedRecords', filter=filter('namespace', 'AWS/KinesisAnalytics') and filter('stat', 'sum'), rollup='sum').publish(label='A', enable=False)
        B = data('InputProcessing.DroppedRecords', filter=filter('namespace', 'AWS/KinesisAnalytics') and filter('stat', 'sum'), rollup='sum').publish(label='B', enable=False)
        C = (A+B).publish(label='C', enable=False)
        K = (C).sum(over='5m').publish(label='K')
        L = (C).sum(over='1h').publish(label='L')
        M = (C).sum(over='24h').publish(label='M')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 900
  unit_prefix        = "Metric"

  histogram_options {
    color_theme = "red"
  }

  legend_options_fields {
    enabled  = true
    property = "Application"
  }
  legend_options_fields {
    enabled  = true
    property = "Id"
  }
  legend_options_fields {
    enabled  = true
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = false
    property = "Flow"
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

  viz_options {
    axis         = "left"
    display_name = "Failed + Dropped"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    display_name = "InputProcessing.DroppedRecords"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "InputProcessing.ProcessingFailedRecords"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    color        = "aquamarine"
    display_name = "24h"
    label        = "M"
    value_suffix = "records"
  }
  viz_options {
    axis         = "left"
    color        = "blue"
    display_name = "5m"
    label        = "K"
    value_suffix = "records"
  }
  viz_options {
    axis         = "left"
    color        = "pink"
    display_name = "1h"
    label        = "L"
    value_suffix = "records"
  }
}

resource "signalfx_dashboard" "sfx_aws_kinesis_analytics_overview" {

  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.sfx_aws_kinesis_analytics.id
  name              = "Kinesis Analytics Overview"
  time_range        = "-1h"

  variable {
    alias                  = "AWSUniqueId"
    apply_if_exist         = false
    property               = "AWSUniqueId"
    replace_only           = false
    restricted_suggestions = false
    value_required         = false
    values                 = []
    values_suggested       = []
  }
  variable {
    alias                  = "Application"
    apply_if_exist         = false
    property               = "Application"
    replace_only           = false
    restricted_suggestions = false
    value_required         = false
    values                 = []
    values_suggested       = []
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_kinesis_analytics_overview_0.id
    row      = 0
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_kinesis_analytics_overview_1.id
    row      = 0
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_kinesis_analytics_overview_2.id
    row      = 0
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_kinesis_analytics_overview_3.id
    row      = 1
    column   = 0
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_kinesis_analytics_overview_4.id
    row      = 1
    column   = 3
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_kinesis_analytics_overview_5.id
    row      = 1
    column   = 6
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_kinesis_analytics_overview_6.id
    row      = 1
    column   = 9
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_kinesis_analytics_overview_7.id
    row      = 2
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_kinesis_analytics_overview_8.id
    row      = 2
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_kinesis_analytics_overview_9.id
    row      = 3
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_kinesis_analytics_overview_10.id
    row      = 3
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_kinesis_analytics_overview_11.id
    row      = 4
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_kinesis_analytics_overview_12.id
    row      = 4
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_kinesis_analytics_overview_13.id
    row      = 5
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_kinesis_analytics_overview_14.id
    row      = 5
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_kinesis_analytics_overview_15.id
    row      = 5
    column   = 8
    height   = 1
    width    = 4
  }

}
