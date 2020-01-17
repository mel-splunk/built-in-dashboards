resource "signalfx_time_chart" "sfx_aws_redshift_overview_0" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "The aggregated CPU utilization for the cluster"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Cluster CPU Utilization"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('CPUUtilization', filter=filter('namespace', 'AWS/Redshift') and filter('stat', 'mean') and filter('ClusterIdentifier', '*')).mean(by=['ClusterIdentifier']).publish(label='A', enable=False)
        D = (A).min().publish(label='D')
        E = (A).percentile(pct=10).publish(label='E')
        G = (A).percentile(pct=50).publish(label='G')
        F = (A).percentile(pct=90).publish(label='F')
        C = (A).max().publish(label='C')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 3600
  unit_prefix        = "Metric"

  axis_left {
    max_value = 110
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "CPUUtilization - Mean by Cluster Identifier"
    label        = "A"
    plot_type    = "AreaChart"
  }
  viz_options {
    axis         = "left"
    color        = "azure"
    display_name = "P10"
    label        = "E"
    plot_type    = "AreaChart"
  }
  viz_options {
    axis         = "left"
    color        = "green"
    display_name = "min"
    label        = "D"
    plot_type    = "AreaChart"
  }
  viz_options {
    axis         = "left"
    color        = "magenta"
    display_name = "max"
    label        = "C"
    plot_type    = "AreaChart"
  }
  viz_options {
    axis         = "left"
    color        = "orange"
    display_name = "P90"
    label        = "F"
    plot_type    = "AreaChart"
  }
  viz_options {
    axis         = "left"
    color        = "yellow"
    display_name = "median"
    label        = "G"
    plot_type    = "AreaChart"
  }
}

resource "signalfx_heatmap_chart" "sfx_aws_redshift_overview_1" {
  description        = "The health status of the cluster"
  disable_sampling   = false
  group_by           = []
  hide_timestamp     = false
  minimum_resolution = 0
  name               = "Cluster Health Status"
  program_text       = <<-EOF
        A = data('HealthStatus', filter=filter('namespace', 'AWS/Redshift') and filter('stat', 'count') and filter('ClusterIdentifier', '*')).count(by=['stat']).publish(label='A', enable=False)
        C = (A).publish(label='C')
    EOF
  unit_prefix        = "Metric"

  color_range {
    color     = "#05ce00"
    max_value = 0
    min_value = 0
  }
}

resource "signalfx_heatmap_chart" "sfx_aws_redshift_overview_2" {
  description        = "Displays maintenance on members of the cluster. Green, when maintenance mode for a cluster is OFF and yellow when maintenance mode if ON"
  disable_sampling   = false
  group_by           = []
  hide_timestamp     = false
  minimum_resolution = 0
  name               = "Maintenance Mode"
  program_text       = "A = data('MaintenanceMode', filter=filter('namespace', 'AWS/Redshift') and filter('stat', 'upper') and filter('ClusterIdentifier', '*')).publish(label='A')"
  unit_prefix        = "Metric"

  color_scale {
    color = "lime_green"
    gt    = 340282346638528860000000000000000000000
    gte   = 340282346638528860000000000000000000000
    lt    = 340282346638528860000000000000000000000
    lte   = 0
  }
  color_scale {
    color = "yellow"
    gt    = 0
    gte   = 340282346638528860000000000000000000000
    lt    = 340282346638528860000000000000000000000
    lte   = 340282346638528860000000000000000000000
  }
}

resource "signalfx_time_chart" "sfx_aws_redshift_overview_3" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "Read in IOPS/sec for the data warehouse cluster"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Read IOPS/sec"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('ReadIOPS', filter=filter('namespace', 'AWS/Redshift') and filter('stat', 'mean') and filter('ClusterIdentifier', '*')).mean(by=['ClusterIdentifier']).publish(label='A', enable=False)
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
    display_name = "ReadIOPS - Mean by DWInstance"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    color        = "azure"
    display_name = "P50"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    color        = "emerald"
    display_name = "P10"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    color        = "green"
    display_name = "min"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    color        = "pink"
    display_name = "P90"
    label        = "E"
  }
  viz_options {
    axis         = "left"
    color        = "purple"
    display_name = "max"
    label        = "F"
  }
}

resource "signalfx_time_chart" "sfx_aws_redshift_overview_4" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "Read latency for the data warehouse cluster"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Read Latency"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('ReadLatency', filter=filter('namespace', 'AWS/Redshift') and filter('stat', 'mean') and filter('ClusterIdentifier', '*')).scale(1000).mean(by=['ClusterIdentifier']).publish(label='A', enable=False)
        B = (A).min().publish(label='B')
        D = (A).percentile(pct=10).publish(label='D')
        E = (A).percentile(pct=50).publish(label='E')
        F = (A).percentile(pct=90).publish(label='F')
        C = (A).max().publish(label='C')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 3600
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
    color        = "aquamarine"
    display_name = "P10"
    label        = "D"
    plot_type    = "AreaChart"
  }
  viz_options {
    axis         = "left"
    color        = "azure"
    display_name = "ReadLatency - Mean by Cluster Identifier"
    label        = "A"
    plot_type    = "AreaChart"
  }
  viz_options {
    axis         = "left"
    color        = "azure"
    display_name = "median"
    label        = "E"
    plot_type    = "AreaChart"
  }
  viz_options {
    axis         = "left"
    color        = "green"
    display_name = "min"
    label        = "B"
    plot_type    = "AreaChart"
  }
  viz_options {
    axis         = "left"
    color        = "pink"
    display_name = "P90"
    label        = "F"
    plot_type    = "AreaChart"
  }
  viz_options {
    axis         = "left"
    color        = "purple"
    display_name = "max"
    label        = "C"
    plot_type    = "AreaChart"
  }
}

resource "signalfx_time_chart" "sfx_aws_redshift_overview_5" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "The read throughput for the data warehouse cluster"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Read Throughput"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('ReadThroughput', filter=filter('namespace', 'AWS/Redshift') and filter('stat', 'mean') and filter('ClusterIdentifier', '*')).mean(by=['ClusterIdentifier']).publish(label='A', enable=False)
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
    display_name = "ReadThroughput - Mean by Cluster Identifier"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    color        = "azure"
    display_name = "median"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    color        = "emerald"
    display_name = "P10"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    color        = "green"
    display_name = "min"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    color        = "pink"
    display_name = "P90"
    label        = "E"
  }
  viz_options {
    axis         = "left"
    color        = "purple"
    display_name = "max"
    label        = "F"
  }
}

resource "signalfx_time_chart" "sfx_aws_redshift_overview_6" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "Writes in IOPS/sec for the data warehouse cluster"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Write IOPS/sec"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('WriteIOPS', filter=filter('namespace', 'AWS/Redshift') and filter('stat', 'mean') and filter('ClusterIdentifier', '*')).mean(by=['ClusterIdentifier']).publish(label='A', enable=False)
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
    display_name = "WriteIOPS - Mean by DWInstance"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    color        = "azure"
    display_name = "median"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    color        = "emerald"
    display_name = "P10"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    color        = "green"
    display_name = "min"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    color        = "pink"
    display_name = "P90"
    label        = "E"
  }
  viz_options {
    axis         = "left"
    color        = "purple"
    display_name = "max"
    label        = "F"
  }
}

resource "signalfx_time_chart" "sfx_aws_redshift_overview_7" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "The write latency for the data warehouse cluster"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Write Latency (ms)"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('WriteLatency', filter=filter('namespace', 'AWS/Redshift') and filter('stat', 'mean') and filter('ClusterIdentifier', '*')).scale(1000).mean(by=['ClusterIdentifier']).publish(label='A', enable=False)
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
    display_name = "WriteLatency - Mean by DWInstance"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    color        = "azure"
    display_name = "median"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    color        = "emerald"
    display_name = "P10"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    color        = "green"
    display_name = "min"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    color        = "pink"
    display_name = "P90"
    label        = "E"
  }
  viz_options {
    axis         = "left"
    color        = "purple"
    display_name = "max"
    label        = "F"
  }
}

resource "signalfx_time_chart" "sfx_aws_redshift_overview_8" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "The writes throughput for the data warehouse cluster"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Write Throughput"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('WriteThroughput', filter=filter('namespace', 'AWS/Redshift') and filter('stat', 'mean') and filter('ClusterIdentifier', '*')).mean(by=['ClusterIdentifier']).publish(label='A', enable=False)
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
    display_name = "WriteThroughput - Mean by Cluster Identifier"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    color        = "azure"
    display_name = "median"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    color        = "emerald"
    display_name = "P10"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    color        = "green"
    display_name = "min"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    color        = "pink"
    display_name = "P90"
    label        = "E"
  }
  viz_options {
    axis         = "left"
    color        = "purple"
    display_name = "max"
    label        = "F"
  }
}

resource "signalfx_time_chart" "sfx_aws_redshift_overview_9" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "Network traffic received into the data warehouse cluster"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Network Receive Throughput"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('NetworkReceiveThroughput', filter=filter('namespace', 'AWS/Redshift') and filter('stat', 'mean') and filter('ClusterIdentifier', '*')).mean(by=['ClusterIdentifier']).publish(label='A', enable=False)
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
    display_name = "NetworkReceiveThroughput - Mean by Cluster Identifier"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    color        = "azure"
    display_name = "median"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    color        = "emerald"
    display_name = "P10"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    color        = "green"
    display_name = "min"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    color        = "pink"
    display_name = "P90"
    label        = "E"
  }
  viz_options {
    axis         = "left"
    color        = "purple"
    display_name = "max"
    label        = "F"
  }
}

resource "signalfx_time_chart" "sfx_aws_redshift_overview_10" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "Network traffic transmitted out from the data warehouse cluster"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Network Transmit Throughput"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('NetworkTransmitThroughput', filter=filter('namespace', 'AWS/Redshift') and filter('stat', 'mean') and filter('ClusterIdentifier', '*')).mean(by=['ClusterIdentifier']).publish(label='A', enable=False)
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
    display_name = "NetworkTransmitThroughput - Mean by Cluster Identifier"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    color        = "aquamarine"
    display_name = "P10"
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
    color        = "pink"
    display_name = "P90"
    label        = "E"
  }
  viz_options {
    axis         = "left"
    color        = "purple"
    display_name = "max"
    label        = "F"
  }
}

resource "signalfx_time_chart" "sfx_aws_redshift_overview_11" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "The amount of storage consumed by the data warehouse cluster"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Amount (bytes) of Disk Space Consumed"
  plot_type          = "AreaChart"
  program_text       = "A = data('PercentageDiskSpaceUsed', filter=filter('namespace', 'AWS/Redshift') and filter('stat', 'mean')).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 3600
  unit_prefix        = "Metric"

  axis_left {
    label     = "bytes"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    color        = "brown"
    display_name = "PercentageDiskSpaceUsed"
    label        = "A"
    plot_type    = "AreaChart"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_redshift_overview_12" {
  color_by                = "Dimension"
  description             = "The total number of data warehouse instances"
  is_timestamp_hidden     = false
  max_precision           = 0
  name                    = "# Data Warehouse Instances"
  program_text            = "A = data('CPUUtilization', filter=filter('namespace', 'AWS/Redshift') and filter('ClusterIdentifier', 'dw-instance') and filter('stat', 'count')).count().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    color        = "blue"
    display_name = "CPUUtilization - Count"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_redshift_overview_13" {
  color_by                = "Dimension"
  description             = "The top 5 consumers with writes to the data warehouse"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top Data Warehouse Writes in IOPS/sec"
  program_text            = "A = data('WriteIOPS', filter=filter('namespace', 'AWS/Redshift') and filter('stat', 'mean') and filter('ClusterIdentifier', '*')).top(count=5).mean(by=['ClusterIdentifier']).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"
}

resource "signalfx_list_chart" "sfx_aws_redshift_overview_14" {
  color_by                = "Dimension"
  description             = "The top 5 consumers impacting read latency to the data warehouse"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top Data Warehouse Read Latency (ms)"
  program_text            = "A = data('ReadLatency', filter=filter('namespace', 'AWS/Redshift') and filter('stat', 'mean') and filter('ClusterIdentifier', '*')).scale(1000).top(count=5).mean(by=['ClusterIdentifier']).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"
}

resource "signalfx_list_chart" "sfx_aws_redshift_overview_15" {
  color_by                = "Dimension"
  description             = "The top 5 consumers for reads to the data warehouse"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top Data Warehouse Reads in IOPS/sec"
  program_text            = "A = data('ReadIOPS', filter=filter('namespace', 'AWS/Redshift') and filter('stat', 'mean') and filter('ClusterIdentifier', '*')).top(count=5).mean(by=['ClusterIdentifier']).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"
}

resource "signalfx_single_value_chart" "sfx_aws_redshift_overview_16" {
  color_by                = "Dimension"
  description             = "The number of active connections to the data warehouse"
  is_timestamp_hidden     = false
  max_precision           = 0
  name                    = "Data Warehouse Connections"
  program_text            = "A = data('DatabaseConnections', filter=filter('namespace', 'AWS/Redshift') and filter('stat', 'count') and filter('ClusterIdentifier', '*')).count(by=['ClusterIdentifier']).publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "DatabaseConnections - Count by Cluster Identifier"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_redshift_overview_17" {
  color_by                = "Dimension"
  description             = "The top 5 instances impacting CPU utilization on the data warehouse"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top Data Warehouse by CPU %"
  program_text            = "A = data('CPUUtilization', filter=filter('namespace', 'AWS/Redshift') and filter('stat', 'mean') and filter('ClusterIdentifier', '*')).top(count=5).mean(by=['ClusterIdentifier']).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"
}

resource "signalfx_list_chart" "sfx_aws_redshift_overview_18" {
  color_by                = "Dimension"
  description             = "The top 5 consumers impacting write latency to the data warehouse"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top Data Warehouse Write Latency (ms)"
  program_text            = "A = data('WriteLatency', filter=filter('namespace', 'AWS/Redshift') and filter('stat', 'mean') and filter('ClusterIdentifier', '*')).scale(1000).top(count=5).mean(by=['ClusterIdentifier']).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"
}

resource "signalfx_dashboard" "sfx_aws_redshift_overview" {

  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.sfx_aws_redshift.id
  name              = "AWS Redshift"

  chart {
    chart_id = signalfx_time_chart.sfx_aws_redshift_overview_0.id
    row      = 0
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_heatmap_chart.sfx_aws_redshift_overview_1.id
    row      = 0
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_heatmap_chart.sfx_aws_redshift_overview_2.id
    row      = 0
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_redshift_overview_3.id
    row      = 1
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_redshift_overview_4.id
    row      = 1
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_redshift_overview_5.id
    row      = 1
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_redshift_overview_6.id
    row      = 2
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_redshift_overview_7.id
    row      = 2
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_redshift_overview_8.id
    row      = 2
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_redshift_overview_9.id
    row      = 3
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_redshift_overview_10.id
    row      = 3
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_redshift_overview_11.id
    row      = 3
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_redshift_overview_12.id
    row      = 4
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_redshift_overview_13.id
    row      = 4
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_redshift_overview_14.id
    row      = 4
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_redshift_overview_15.id
    row      = 5
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_redshift_overview_16.id
    row      = 5
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_redshift_overview_17.id
    row      = 5
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_redshift_overview_18.id
    row      = 6
    column   = 0
    height   = 1
    width    = 4
  }

}
