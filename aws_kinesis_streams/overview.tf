# signalfx_single_value_chart.sfx_aws_kinesis_streams_overview_0:
resource "signalfx_single_value_chart" "sfx_aws_kinesis_streams_overview_0" {
  color_by                = "Dimension"
  is_timestamp_hidden     = false
  max_precision           = 0
  name                    = "Active Streams"
  program_text            = "A = data('GetRecords.Latency', filter=filter('namespace', 'AWS/Kinesis') and filter('stat', 'mean')).count().above(0).publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Binary"

  viz_options {
    display_name = "active streams"
    label        = "A"
  }
}

# signalfx_list_chart.sfx_aws_kinesis_streams_overview_1:
resource "signalfx_list_chart" "sfx_aws_kinesis_streams_overview_1" {
  color_by                = "Dimension"
  description             = "The number of records successfully put to the Kinesis stream"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Incoming Records per Stream"
  program_text            = "A = data('IncomingRecords', filter=filter('namespace', 'AWS/Kinesis') and filter('stat', 'count'), rollup='latest').publish(label='A')"
  secondary_visualization = "None"
  unit_prefix             = "Metric"

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
    property = "StreamName"
  }

  viz_options {
    display_name = "Incoming Records"
    label        = "A"
  }
}

# signalfx_list_chart.sfx_aws_kinesis_streams_overview_2:
resource "signalfx_list_chart" "sfx_aws_kinesis_streams_overview_2" {
  color_by                = "Dimension"
  description             = "The average number of bytes successfully put to the Kinesis stream"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Incoming Bytes per Stream"
  program_text            = "A = data('IncomingBytes', filter=filter('namespace', 'AWS/Kinesis') and filter('stat', 'mean')).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Binary"

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
    property = "StreamName"
  }

  viz_options {
    display_name = "Incoming Bytes"
    label        = "A"
  }
}

# signalfx_list_chart.sfx_aws_kinesis_streams_overview_3:
resource "signalfx_list_chart" "sfx_aws_kinesis_streams_overview_3" {
  color_by                = "Dimension"
  description             = "The average time taken per PutRecord operation in milliseconds"
  disable_sampling        = false
  max_precision           = 2
  name                    = "Put  Record Latency (ms) per Stream"
  program_text            = "A = data('PutRecord.Latency', filter=filter('namespace', 'AWS/Kinesis') and filter('stat', 'mean'), rollup='latest').publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"

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
    enabled  = true
    property = "StreamName"
  }
  legend_options_fields {
    enabled  = false
    property = "namespace"
  }
  legend_options_fields {
    enabled  = false
    property = "AWSUniqueId"
  }

  viz_options {
    display_name = "latency (ms)"
    label        = "A"
  }
}

# signalfx_list_chart.sfx_aws_kinesis_streams_overview_4:
resource "signalfx_list_chart" "sfx_aws_kinesis_streams_overview_4" {
  color_by                = "Dimension"
  description             = "The time taken per GetRecords operation in milliseconds"
  disable_sampling        = false
  max_precision           = 3
  name                    = "Get Records Latency (ms) per Stream"
  program_text            = "A = data('GetRecords.Latency', filter=filter('stat', 'mean') and filter('namespace', 'AWS/Kinesis'), rollup='latest').publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"

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
    property = "StreamName"
  }

  viz_options {
    display_name = "latency (ms)"
    label        = "A"
  }
}

# signalfx_list_chart.sfx_aws_kinesis_streams_overview_5:
resource "signalfx_list_chart" "sfx_aws_kinesis_streams_overview_5" {
  color_by                = "Dimension"
  description             = "The age of the last record in all GetRecords calls made against an Kinesis stream"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Iterator Age (ms) per Stream"
  program_text            = "A = data('GetRecords.IteratorAgeMilliseconds', filter=filter('namespace', 'AWS/Kinesis') and filter('stat', 'mean')).publish(label='A')"
  secondary_visualization = "None"
  unit_prefix             = "Metric"

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
    property = "StreamName"
  }

  viz_options {
    display_name = "Iterator Age Milliseconds"
    label        = "A"
  }
}

# signalfx_list_chart.sfx_aws_kinesis_streams_overview_6:
resource "signalfx_list_chart" "sfx_aws_kinesis_streams_overview_6" {
  color_by                = "Dimension"
  description             = "The number of GetRecords calls throttled for the stream"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Read Provisioned Throughput Exceeded"
  program_text            = "A = data('ReadProvisionedThroughputExceeded', filter=filter('namespace', 'AWS/Kinesis') and filter('stat', 'mean'), rollup='latest').publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"

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
    property = "StreamName"
  }
  legend_options_fields {
    enabled  = false
    property = "namespace"
  }
  legend_options_fields {
    enabled  = false
    property = "stat"
  }
  legend_options_fields {
    enabled  = false
    property = "AWSUniqueId"
  }

  viz_options {
    display_name = "throughput exceeded"
    label        = "A"
  }
}

# signalfx_list_chart.sfx_aws_kinesis_streams_overview_7:
resource "signalfx_list_chart" "sfx_aws_kinesis_streams_overview_7" {
  color_by                = "Dimension"
  description             = "The number of records rejected due to throttling for the stream from PutRecord and PutRecords"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Write Provisioned Throughput Exceeded"
  program_text            = "A = data('WriteProvisionedThroughputExceeded', filter=filter('namespace', 'AWS/Kinesis') and filter('stat', 'mean')).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"

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
    property = "StreamName"
  }

  viz_options {
    display_name = "throughtput exceeded"
    label        = "A"
  }
}

# signalfx_time_chart.sfx_aws_kinesis_streams_overview_8:
resource "signalfx_time_chart" "sfx_aws_kinesis_streams_overview_8" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "The number of successful GetRecords operations per stream"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Successful GetRecords per Stream"
  plot_type          = "LineChart"
  program_text       = "A = data('GetRecords.Success', filter=filter('namespace', 'AWS/Kinesis') and filter('stat', 'count'), rollup='latest').publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label = "# records"
  }

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
    property = "StreamName"
  }

  viz_options {
    axis         = "left"
    display_name = "Successful GetRecords"
    label        = "A"
  }
}

# signalfx_time_chart.sfx_aws_kinesis_streams_overview_9:
resource "signalfx_time_chart" "sfx_aws_kinesis_streams_overview_9" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "The number of successful PutRecord and PutRecords operations per Kinesis stream"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Successful PutRecord(s) per Stream"
  plot_type          = "LineChart"
  program_text       = <<-EOF
        A = data('PutRecord.Success', filter=filter('namespace', 'AWS/Kinesis') and filter('stat', 'count'), rollup='latest').publish(label='A')
        B = data('PutRecords.Success', filter=filter('namespace', 'AWS/Kinesis') and filter('stat', 'count'), rollup='latest').publish(label='B')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label = "# records"
  }

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
    property = "StreamName"
  }

  viz_options {
    axis         = "left"
    display_name = "PutRecord.Success"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    display_name = "PutRecords.Success"
    label        = "B"
  }
}

resource "signalfx_dashboard" "sfx_aws_kinesis_streams_overview" {

  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.sfx_aws_kinesis_streams.id
  description       = "An overview of all Amazon Kinesis Streams"
  name              = "Kinesis Streams Overview"

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_kinesis_streams_overview_0.id
    row      = 0
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_kinesis_streams_overview_1.id
    row      = 0
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_kinesis_streams_overview_2.id
    row      = 0
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_kinesis_streams_overview_3.id
    row      = 1
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_kinesis_streams_overview_4.id
    row      = 1
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_kinesis_streams_overview_5.id
    row      = 1
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_kinesis_streams_overview_6.id
    row      = 2
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_kinesis_streams_overview_7.id
    row      = 2
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_kinesis_streams_overview_8.id
    row      = 3
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_kinesis_streams_overview_9.id
    row      = 3
    column   = 6
    height   = 1
    width    = 6
  }

}
