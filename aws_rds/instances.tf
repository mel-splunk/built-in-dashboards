resource "signalfx_single_value_chart" "sfx_aws_lambda_rds_instances_0" {
  color_by                = "Dimension"
  is_timestamp_hidden     = false
  max_precision           = 0
  name                    = "# DB Instances"
  program_text            = "A = data('CPUUtilization', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean') and filter('DBInstanceIdentifier', '*'), extrapolation='last_value', maxExtrapolations=5).mean(by=['aws_account_id', 'aws_region', 'DBInstanceIdentifier']).count().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "CPUUtilization - Mean by DBInstanceIdentifier - Count"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_lambda_rds_instances_1" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Classes for all DB instances"
  program_text            = "A = data('CPUUtilization', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean') and filter('DatabaseClass', '*'), extrapolation='last_value', maxExtrapolations=5).count(by=['DatabaseClass']).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"

  viz_options {
    label = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_lambda_rds_instances_2" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Engine Names for all DB Instances"
  program_text            = "A = data('CPUUtilization', filter=filter('namespace', 'AWS/RDS') and filter('EngineName', '*') and filter('stat', 'mean')).mean(over='1h').count(by=['EngineName']).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"
}

resource "signalfx_time_chart" "sfx_aws_lambda_rds_instances_3" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Read IOPS/sec"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('ReadIOPS', filter=filter('stat', 'mean') and filter('namespace', 'AWS/RDS') and filter('DBInstanceIdentifier', '*')).mean(by=['aws_account_id','aws_region','DBInstanceIdentifier']).publish(label='A', enable=False)
        B = (A).min().publish(label='B')
        C = (A).percentile(pct=10).publish(label='C')
        D = (A).percentile(pct=50).publish(label='D')
        E = (A).percentile(pct=90).publish(label='E')
        F = (A).max().publish(label='F')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "iops/sec"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "ReadIOPS - Mean by DBInstanceIdentifier"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    color        = "aquamarine"
    display_name = "p10"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    color        = "azure"
    display_name = "median"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    color        = "green"
    display_name = "min"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    color        = "magenta"
    display_name = "max"
    label        = "F"
  }
  viz_options {
    axis         = "left"
    color        = "pink"
    display_name = "p90"
    label        = "E"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_rds_instances_4" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Read Latency (ms)"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('ReadLatency', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean') and filter('DBInstanceIdentifier', '*')).mean(by=['aws_account_id','aws_region','DBInstanceIdentifier']).scale(1000).publish(label='A', enable=False)
        B = (A).min().publish(label='B')
        C = (A).percentile(pct=10).publish(label='C')
        D = (A).percentile(pct=50).publish(label='D')
        E = (A).percentile(pct=90).publish(label='E')
        F = (A).max().publish(label='F')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "ms"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "ReadLatency - Mean by DBInstanceIdentifier - Scale:1000"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    color        = "aquamarine"
    display_name = "p10"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    color        = "azure"
    display_name = "median"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    color        = "green"
    display_name = "min"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    color        = "magenta"
    display_name = "max"
    label        = "F"
  }
  viz_options {
    axis         = "left"
    color        = "pink"
    display_name = "p90"
    label        = "E"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_rds_instances_5" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Read Throughput"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('ReadThroughput', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean') and filter('DBInstanceIdentifier', '*')).mean(by=['aws_account_id', 'aws_region', 'DBInstanceIdentifier']).publish(label='A', enable=False)
        B = (A).min().publish(label='B')
        C = (A).percentile(pct=10).publish(label='C')
        D = (A).percentile(pct=50).publish(label='D')
        E = (A).percentile(pct=90).publish(label='E')
        F = (A).max().publish(label='F')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "bytes/sec"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "ReadThroughput - Mean by DBInstanceIdentifier"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    color        = "aquamarine"
    display_name = "p10"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    color        = "azure"
    display_name = "median"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    color        = "green"
    display_name = "min"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    color        = "magenta"
    display_name = "max"
    label        = "F"
  }
  viz_options {
    axis         = "left"
    color        = "pink"
    display_name = "p90"
    label        = "E"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_rds_instances_6" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Write IOPS/sec"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('WriteIOPS', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean') and filter('DBInstanceIdentifier', '*')).mean(by=['aws_account_id', 'aws_region', 'DBInstanceIdentifier']).publish(label='A', enable=False)
        B = (A).min().publish(label='B')
        C = (A).percentile(pct=10).publish(label='C')
        D = (A).percentile(pct=50).publish(label='D')
        E = (A).percentile(pct=90).publish(label='E')
        F = (A).max().publish(label='F')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "iops/sec"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "WriteIOPS - Mean by DBInstanceIdentifier"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    color        = "aquamarine"
    display_name = "p10"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    color        = "azure"
    display_name = "median"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    color        = "green"
    display_name = "min"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    color        = "magenta"
    display_name = "max"
    label        = "F"
  }
  viz_options {
    axis         = "left"
    color        = "pink"
    display_name = "p90"
    label        = "E"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_rds_instances_7" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Write Latency (ms)"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('WriteLatency', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean') and filter('DBInstanceIdentifier', '*')).mean(by=['aws_account_id','aws_region','DBInstanceIdentifier']).scale(1000).publish(label='A', enable=False)
        B = (A).min().publish(label='B')
        C = (A).percentile(pct=10).publish(label='C')
        D = (A).percentile(pct=50).publish(label='D')
        E = (A).percentile(pct=90).publish(label='E')
        F = (A).max().publish(label='F')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "ms"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "WriteLatency - Mean by DBInstanceIdentifier - Scale:1000"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    color        = "aquamarine"
    display_name = "p10"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    color        = "azure"
    display_name = "median"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    color        = "green"
    display_name = "min"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    color        = "magenta"
    display_name = "max"
    label        = "F"
  }
  viz_options {
    axis         = "left"
    color        = "pink"
    display_name = "p90"
    label        = "E"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_rds_instances_8" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Write Throughput"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('ReadThroughput', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean') and filter('DBInstanceIdentifier', '*')).mean(by=['aws_account_id','aws_region','DBInstanceIdentifier']).publish(label='A', enable=False)
        B = (A).min().publish(label='B')
        C = (A).percentile(pct=10).publish(label='C')
        D = (A).percentile(pct=50).publish(label='D')
        E = (A).percentile(pct=90).publish(label='E')
        F = (A).max().publish(label='F')
    EOF
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
    display_name = "ReadThroughput - Mean by DBInstanceIdentifier"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    color        = "aquamarine"
    display_name = "p10"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    color        = "azure"
    display_name = "median"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    color        = "green"
    display_name = "min"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    color        = "magenta"
    display_name = "max"
    label        = "F"
  }
  viz_options {
    axis         = "left"
    color        = "pink"
    display_name = "p90"
    label        = "E"
  }
}

resource "signalfx_list_chart" "sfx_aws_lambda_rds_instances_9" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 3
  name                    = "Top DBs by Read Latency (ms)"
  program_text            = "A = data('ReadLatency', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean') and filter('DBInstanceIdentifier', '*')).mean(by=['aws_account_id','aws_region','DBInstanceIdentifier']).scale(1000).top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  time_range              = 900
  unit_prefix             = "Metric"
}

resource "signalfx_list_chart" "sfx_aws_lambda_rds_instances_10" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 3
  name                    = "Top DBs by Write Latency (ms)"
  program_text            = "A = data('WriteLatency', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean') and filter('DBInstanceIdentifier', '*')).mean(by=['aws_account_id','aws_region','DBInstanceIdentifier']).scale(1000).top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  time_range              = 900
  unit_prefix             = "Metric"
}

resource "signalfx_list_chart" "sfx_aws_lambda_rds_instances_11" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 3
  name                    = "Top DBs by CPU %"
  program_text            = "A = data('CPUUtilization', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean') and filter('DBInstanceIdentifier', '*')).mean(by=['aws_account_id','aws_region','DBInstanceIdentifier']).top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  time_range              = 900
  unit_prefix             = "Metric"
}

resource "signalfx_list_chart" "sfx_aws_lambda_rds_instances_12" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 3
  name                    = "Top DBs by # Connections"
  program_text            = "A = data('DatabaseConnections', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean') and filter('DBInstanceIdentifier', '*')).mean(by=['aws_account_id','aws_region','DBInstanceIdentifier']).top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  time_range              = 900
  unit_prefix             = "Metric"
}

resource "signalfx_time_chart" "sfx_aws_lambda_rds_instances_13" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Network Receive Throughput"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('NetworkReceiveThroughput', filter=filter('stat', 'mean') and filter('namespace', 'AWS/RDS') and filter('DBInstanceIdentifier', '*')).mean(by=['aws_account_id','aws_region','DBInstanceIdentifier']).publish(label='A', enable=False)
        B = (A).min().publish(label='B')
        C = (A).percentile(pct=10).publish(label='C')
        D = (A).percentile(pct=50).publish(label='D')
        E = (A).percentile(pct=90).publish(label='E')
        F = (A).max().publish(label='F')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Binary"

  axis_left {
    label     = "bytes/sec"
    min_value = 0
  }

  axis_right {
    label = "bytes in - BLUE"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    color        = "aquamarine"
    display_name = "p10"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    color        = "azure"
    display_name = "NetworkReceiveThroughput - Mean by DBInstanceIdentifier"
    label        = "A"
    plot_type    = "AreaChart"
  }
  viz_options {
    axis         = "left"
    color        = "azure"
    display_name = "median"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    color        = "green"
    display_name = "min"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    color        = "magenta"
    display_name = "max"
    label        = "F"
  }
  viz_options {
    axis         = "left"
    color        = "pink"
    display_name = "p90"
    label        = "E"
  }
}

resource "signalfx_time_chart" "sfx_aws_lambda_rds_instances_14" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Network Transmit Throughput"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('NetworkTransmitThroughput', filter=filter('stat', 'mean') and filter('namespace', 'AWS/RDS') and filter('DBInstanceIdentifier', '*')).mean(by=['aws_account_id','aws_region','DBInstanceIdentifier']).publish(label='A', enable=False)
        B = (A).min().publish(label='B')
        C = (A).percentile(pct=10).publish(label='C')
        D = (A).percentile(pct=50).publish(label='D')
        E = (A).percentile(pct=90).publish(label='E')
        F = (A).max().publish(label='F')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Binary"

  axis_left {
    label     = "bytes/sec"
    min_value = 0
  }

  axis_right {
    label = "bytes in - BLUE"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    color        = "aquamarine"
    display_name = "p10"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    color        = "azure"
    display_name = "NetworkTransmitThroughput - Mean by DBInstanceIdentifier"
    label        = "A"
    plot_type    = "AreaChart"
  }
  viz_options {
    axis         = "left"
    color        = "azure"
    display_name = "median"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    color        = "green"
    display_name = "min"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    color        = "magenta"
    display_name = "max"
    label        = "F"
  }
  viz_options {
    axis         = "left"
    color        = "pink"
    display_name = "p90"
    label        = "E"
  }
}

resource "signalfx_list_chart" "sfx_aws_lambda_rds_instances_15" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 3
  name                    = "Top DBs by Read IOPS/sec"
  program_text            = "A = data('ReadIOPS', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean') and filter('DBInstanceIdentifier', '*')).mean(by=['aws_account_id','aws_region','DBInstanceIdentifier']).top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  time_range              = 900
  unit_prefix             = "Metric"
}

resource "signalfx_list_chart" "sfx_aws_lambda_rds_instances_16" {
  color_by                = "Dimension"
  description             = "Count/Second"
  disable_sampling        = false
  max_precision           = 3
  name                    = "Top DBs by Write IOPS/sec"
  program_text            = "A = data('WriteIOPS', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean') and filter('DBInstanceIdentifier', '*')).mean(by=['aws_account_id', 'aws_region', 'DBInstanceIdentifier']).top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  time_range              = 900
  unit_prefix             = "Metric"
}

resource "signalfx_list_chart" "sfx_aws_lambda_rds_instances_17" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 3
  name                    = "Top DBs by Disk Queue Depth"
  program_text            = "A = data('DiskQueueDepth', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean') and filter('DBInstanceIdentifier', '*')).mean(by=['aws_account_id', 'aws_region', 'DBInstanceIdentifier']).top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  time_range              = 900
  unit_prefix             = "Metric"
}

resource "signalfx_dashboard" "sfx_aws_lambda_rds_instances" {

  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.sfx_aws_rds.id
  description       = "Default dashboard."
  name              = "RDS Instances"

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_lambda_rds_instances_0.id
    row      = 0
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_lambda_rds_instances_1.id
    row      = 0
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_lambda_rds_instances_2.id
    row      = 0
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_rds_instances_3.id
    row      = 1
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_rds_instances_4.id
    row      = 1
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_rds_instances_5.id
    row      = 1
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_rds_instances_6.id
    row      = 2
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_rds_instances_7.id
    row      = 2
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_rds_instances_8.id
    row      = 2
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_lambda_rds_instances_9.id
    row      = 3
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_lambda_rds_instances_10.id
    row      = 3
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_lambda_rds_instances_11.id
    row      = 3
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_lambda_rds_instances_12.id
    row      = 4
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_rds_instances_13.id
    row      = 4
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_lambda_rds_instances_14.id
    row      = 4
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_lambda_rds_instances_15.id
    row      = 5
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_lambda_rds_instances_16.id
    row      = 5
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_lambda_rds_instances_17.id
    row      = 5
    column   = 8
    height   = 1
    width    = 4
  }

}
