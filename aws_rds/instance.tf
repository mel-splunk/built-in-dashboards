resource "signalfx_time_chart" "sfx_aws_lambda_rds_instance_0" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Read/Write Ops/sec"
  plot_type          = "ColumnChart"
  program_text       = <<-EOF
        A = data('ReadIOPS', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean')).publish(label='A')
        B = data('WriteIOPS', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean')).publish(label='B')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "reads/sec - RED"
    min_value = 0
  }

  axis_right {
    label     = "writes/sec - BLUE"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    color        = "brown"
    display_name = "ReadIOPS"
    label        = "A"
    plot_type    = "ColumnChart"
  }
  viz_options {
    axis         = "right"
    color        = "blue"
    display_name = "WriteIOPS"
    label        = "B"
    plot_type    = "ColumnChart"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_rds_instance_1" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "latency per operation"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Read/Write Latency (ms)"
  plot_type          = "ColumnChart"
  program_text       = <<-EOF
        A = data('ReadLatency', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean')).scale(1000).publish(label='A')
        B = data('WriteLatency', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean')).scale(1000).publish(label='B')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "reads - RED"
    min_value = 0
  }

  axis_right {
    label     = "writes - BLUE"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    color        = "brown"
    display_name = "ReadLatency - Scale:1000"
    label        = "A"
  }
  viz_options {
    axis         = "right"
    color        = "blue"
    display_name = "WriteLatency - Scale:1000"
    label        = "B"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_rds_instance_2" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "bytes/sec"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Read/Write Throughput"
  plot_type          = "ColumnChart"
  program_text       = <<-EOF
        A = data('ReadThroughput', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean')).publish(label='A')
        B = data('WriteThroughput', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean')).publish(label='B')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "reads - RED"
    min_value = 0
  }

  axis_right {
    label     = "writes - BLUE"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    color        = "brown"
    display_name = "ReadThroughput"
    label        = "A"
  }
  viz_options {
    axis         = "right"
    color        = "blue"
    display_name = "WriteThroughput"
    label        = "B"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_rds_instance_3" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "CPU %"
  plot_type          = "AreaChart"
  program_text       = "A = data('CPUUtilization', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean')).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "cpu %"
    max_value = 110
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "CPUUtilization"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_rds_instance_4" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Free RAM"
  plot_type          = "AreaChart"
  program_text       = "A = data('FreeableMemory', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean')).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Binary"

  axis_left {
    label     = "bytes"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "FreeableMemory"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_rds_instance_5" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Free Storage Space"
  plot_type          = "AreaChart"
  program_text       = "A = data('FreeStorageSpace', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean')).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Binary"

  axis_left {
    label     = "bytes"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "FreeStorageSpace"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_rds_instance_6" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Database Connections"
  plot_type          = "AreaChart"
  program_text       = "A = data('DatabaseConnections', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean')).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "# connections"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "DatabaseConnections"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_rds_instance_7" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Network Receive Throughput"
  plot_type          = "AreaChart"
  program_text       = "A = data('NetworkReceiveThroughput', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean')).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Binary"

  axis_left {
    label     = "bytes/sec"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "NetworkReceiveThroughput"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_rds_instance_8" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Network Transmit Throughput"
  plot_type          = "AreaChart"
  program_text       = "A = data('NetworkTransmitThroughput', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean')).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Binary"

  axis_left {
    label     = "bytes/sec"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "NetworkTransmitThroughput"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_rds_instance_9" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Avg Disk Queue Depth"
  plot_type          = "AreaChart"
  program_text       = "A = data('DiskQueueDepth', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean')).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "# pending requests"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "DiskQueueDepth"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_rds_instance_10" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Swap Space Used"
  plot_type          = "AreaChart"
  program_text       = "A = data('SwapUsage', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean')).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Binary"

  axis_left {
    label     = "bytes"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "SwapUsage"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_rds_instance_11" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "R/W IOPS 24h Change %"
  plot_type          = "LineChart"
  program_text       = <<-EOF
        A = data('ReadIOPS', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean')).mean(over='1h').publish(label='A', enable=False)
        B = data('WriteIOPS', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean')).mean(over='1h').publish(label='B', enable=False)
        C = (A).timeshift('1d').publish(label='C', enable=False)
        D = (B).timeshift('1d').publish(label='D', enable=False)
        E = ((A-C)/C*100).publish(label='E')
        F = ((B-D)/D*100).publish(label='F')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label = "reads - RED"
  }

  axis_right {
    label = "writes - BLUE"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "A - Timeshift 1d"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    display_name = "B - Timeshift 1d"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    color        = "azure"
    display_name = "(B-H)/H*100"
    label        = "F"
  }
  viz_options {
    axis         = "left"
    color        = "purple"
    display_name = "(A-G)/G*100"
    label        = "E"
  }
  viz_options {
    axis         = "left"
    color        = "purple"
    display_name = "ReadIOPS - Mean(1h)"
    label        = "A"
  }
  viz_options {
    axis         = "right"
    color        = "azure"
    display_name = "WriteIOPS - Mean(1h)"
    label        = "B"
  }
}

resource "signalfx_dashboard" "sfx_aws_lambda_rds_instance" {

  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.sfx_aws_rds.id
  name              = "RDS Instance"

  variable {
    alias                  = "instance"
    apply_if_exist         = false
    description            = "RDS DB Instance"
    property               = "DBInstanceIdentifier"
    replace_only           = false
    restricted_suggestions = false
    value_required         = true
    values = [
      "Choose Instance",
    ]
    values_suggested = []
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_rds_instance_0.id
    row      = 0
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_rds_instance_1.id
    row      = 0
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_rds_instance_2.id
    row      = 0
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_rds_instance_3.id
    row      = 1
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_rds_instance_4.id
    row      = 1
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_rds_instance_5.id
    row      = 1
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_rds_instance_6.id
    row      = 2
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_rds_instance_7.id
    row      = 2
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_rds_instance_8.id
    row      = 2
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_rds_instance_9.id
    row      = 3
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_rds_instance_10.id
    row      = 3
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_rds_instance_11.id
    row      = 3
    column   = 8
    height   = 1
    width    = 4
  }

}
