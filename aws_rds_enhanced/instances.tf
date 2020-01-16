resource "signalfx_single_value_chart" "sfx_aws_rds_enhanced_instances_count" {
  color_by                = "Dimension"
  max_precision           = 0
  name                    = "# DB Instances"
  program_text            = "A = data('cpuUtilization.total', filter=(not filter('EngineName', 'Aurora'))).count().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "cpuUtilization.total - Count"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_rds_enhanced_instances_by_engine" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "# DB Instances by Engine"
  program_text            = "A = data('cpuUtilization.total', filter=(not filter('EngineName', 'Aurora'))).count(by=['EngineName']).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"

  legend_options_fields {
    enabled  = true
    property = "EngineName"
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
    display_name = "cpuUtilization.total - Count by EngineName"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_instances_cpu" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Total CPU %"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('cpuUtilization.total', filter=(not filter('EngineName', 'Aurora'))).publish(label='A', enable=False)
        K = (A).min().publish(label='K')
        F = (A).percentile(pct=10).publish(label='F')
        G = (A).percentile(pct=50).publish(label='G')
        H = (A).percentile(pct=90).publish(label='H')
        I = (A).max().publish(label='I')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 900
  unit_prefix        = "Metric"

  axis_left {
    label = "% CPU Utilized"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "Maximum"
    label        = "I"
  }
  viz_options {
    axis         = "left"
    display_name = "Minimum"
    label        = "K"
  }
  viz_options {
    axis         = "left"
    display_name = "P10"
    label        = "F"
  }
  viz_options {
    axis         = "left"
    display_name = "P50"
    label        = "G"
  }
  viz_options {
    axis         = "left"
    display_name = "P90"
    label        = "H"
  }
}

resource "signalfx_list_chart" "sfx_aws_rds_enhanced_instances_top_cpu" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top 5 DBs by CPU %"
  program_text            = "A = data('cpuUtilization.total', filter=(not filter('EngineName', 'Aurora'))).top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"

  legend_options_fields {
    enabled  = false
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = false
    property = "EngineName"
  }
  legend_options_fields {
    enabled  = true
    property = "instanceResourceID"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_originatingMetric"
  }
  legend_options_fields {
    enabled  = false
    property = "Namespace"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_metric"
  }

  viz_options {
    display_name = "cpuUtilization.total - Top 5"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_instances_reads" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "ReadIOs/sec"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('diskIO.readIOsPS', filter=(not filter('EngineName', 'Aurora'))).publish(label='A', enable=False)
        G = (A).min().publish(label='G')
        H = (A).percentile(pct=10).publish(label='H')
        I = (A).percentile(pct=50).publish(label='I')
        J = (A).percentile(pct=90).publish(label='J')
        K = (A).max().publish(label='K')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 900
  unit_prefix        = "Metric"

  axis_left {
    label = "Read ops/sec"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "diskIO.readIOsPS"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    color        = "blue"
    display_name = "A - P10"
    label        = "H"
  }
  viz_options {
    axis         = "left"
    color        = "brown"
    display_name = "A - P50"
    label        = "I"
  }
  viz_options {
    axis         = "left"
    color        = "gray"
    display_name = "A - Minimum"
    label        = "G"
  }
  viz_options {
    axis         = "left"
    color        = "green"
    display_name = "A - Maximum"
    label        = "K"
  }
  viz_options {
    axis         = "left"
    color        = "purple"
    display_name = "A - P90"
    label        = "J"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_instances_reads_thru" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Read Throughput"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('diskIO.readKbPS').publish(label='A', enable=False)
        B = (A).min().publish(label='B')
        C = (A).percentile(pct=10).publish(label='C')
        D = (A).percentile(pct=50).publish(label='D')
        E = (A).percentile(pct=90).publish(label='E')
        F = (A).max().publish(label='F')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 900
  unit_prefix        = "Metric"

  axis_left {
    label = "kb/sec"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "diskIO.readKbPS"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    color        = "azure"
    display_name = "A - P90"
    label        = "E"
  }
  viz_options {
    axis         = "left"
    color        = "brown"
    display_name = "A - Maximum"
    label        = "F"
  }
  viz_options {
    axis         = "left"
    color        = "gray"
    display_name = "A - P50"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    color        = "green"
    display_name = "A - P10"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    color        = "magenta"
    display_name = "A - Minimum"
    label        = "B"
  }
}

resource "signalfx_list_chart" "sfx_aws_rds_enhanced_instances_top_reads" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top 5 DBs by ReadIOs/sec"
  program_text            = "A = data('diskIO.readIOsPS', filter=(not filter('EngineName', 'Aurora'))).top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"

  legend_options_fields {
    enabled  = false
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = true
    property = "device"
  }
  legend_options_fields {
    enabled  = false
    property = "EngineName"
  }
  legend_options_fields {
    enabled  = true
    property = "instanceResourceID"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_originatingMetric"
  }
  legend_options_fields {
    enabled  = false
    property = "Namespace"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_metric"
  }

  viz_options {
    display_name = "ReadIOs/sec"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_rds_enhanced_instances_top_reads_thru" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top 5 DBs by Read Throughput"
  program_text            = "A = data('diskIO.readKbPS').top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"

  legend_options_fields {
    enabled  = false
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = true
    property = "device"
  }
  legend_options_fields {
    enabled  = false
    property = "EngineName"
  }
  legend_options_fields {
    enabled  = true
    property = "instanceResourceID"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_originatingMetric"
  }
  legend_options_fields {
    enabled  = false
    property = "Namespace"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_metric"
  }

  viz_options {
    display_name = "diskIO.readKbPS - Top 5"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_instances_writes" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "WriteIOs/sec"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('diskIO.writeIOsPS', filter=(not filter('EngineName', 'Aurora'))).publish(label='A', enable=False)
        B = (A).min().publish(label='B')
        C = (A).percentile(pct=10).publish(label='C')
        D = (A).percentile(pct=50).publish(label='D')
        E = (A).percentile(pct=90).publish(label='E')
        F = (A).max().publish(label='F')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 900
  unit_prefix        = "Metric"

  axis_left {
    label = "Write ops/sec"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "A - Maximum"
    label        = "F"
  }
  viz_options {
    axis         = "left"
    display_name = "A - Minimum"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "A - P10"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    display_name = "A - P50"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    display_name = "A - P90"
    label        = "E"
  }
  viz_options {
    axis         = "left"
    display_name = "diskIO.writeIOsPS"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_instances_writes_thru" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Write Throughput"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('diskIO.writeKbPS').publish(label='A', enable=False)
        B = (A).min().publish(label='B')
        C = (A).percentile(pct=10).publish(label='C')
        D = (A).percentile(pct=50).publish(label='D')
        E = (A).percentile(pct=90).publish(label='E')
        F = (A).max().publish(label='F')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 900
  unit_prefix        = "Metric"

  axis_left {
    label = "kb/sec"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "A - Maximum"
    label        = "F"
  }
  viz_options {
    axis         = "left"
    display_name = "A - Minimum"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "A - P10"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    display_name = "A - P50"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    display_name = "A - P90"
    label        = "E"
  }
  viz_options {
    axis         = "left"
    display_name = "diskIO.writeKbPS"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_rds_enhanced_instances_top_writes" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top 5 DBs by WriteIOs/sec"
  program_text            = "A = data('diskIO.writeIOsPS', filter=(not filter('EngineName', 'Aurora'))).top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"

  legend_options_fields {
    enabled  = false
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = true
    property = "device"
  }
  legend_options_fields {
    enabled  = false
    property = "EngineName"
  }
  legend_options_fields {
    enabled  = true
    property = "instanceResourceID"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_originatingMetric"
  }
  legend_options_fields {
    enabled  = false
    property = "Namespace"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_metric"
  }

  viz_options {
    display_name = "WriteIOs/sec"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_rds_enhanced_instances_top_writes_thru" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top 5 DBs by Write Throughput"
  program_text            = "A = data('diskIO.writeKbPS').top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"

  legend_options_fields {
    enabled  = false
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = true
    property = "device"
  }
  legend_options_fields {
    enabled  = false
    property = "EngineName"
  }
  legend_options_fields {
    enabled  = true
    property = "instanceResourceID"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_originatingMetric"
  }
  legend_options_fields {
    enabled  = false
    property = "Namespace"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_metric"
  }

  viz_options {
    display_name = "diskIO.writeKbPS - Top 5"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_instances_net_bytes" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Network Traffic (bytes/sec)"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('network.rx', filter=(not filter('EngineName', 'Aurora'))).publish(label='A', enable=False)
        G = data('network.tx', filter=(not filter('EngineName', 'Aurora'))).publish(label='G', enable=False)
        H = (A+G).publish(label='H', enable=False)
        B = (H).min().publish(label='B')
        C = (H).percentile(pct=10).publish(label='C')
        D = (H).percentile(pct=50).publish(label='D')
        E = (H).percentile(pct=90).publish(label='E')
        F = (H).max().publish(label='F')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 900
  unit_prefix        = "Metric"

  axis_left {
    label = "bytes/sec"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "A+G"
    label        = "H"
  }
  viz_options {
    axis         = "left"
    display_name = "Maximum"
    label        = "F"
  }
  viz_options {
    axis         = "left"
    display_name = "Minimum"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "P10"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    display_name = "P50"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    display_name = "P90"
    label        = "E"
  }
  viz_options {
    axis         = "left"
    display_name = "network.rx"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    display_name = "network.tx"
    label        = "G"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_instances_queue_len" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Average Queue Length"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('diskIO.avgQueueLen').publish(label='A', enable=False)
        B = (A).min().publish(label='B')
        C = (A).percentile(pct=10).publish(label='C')
        D = (A).percentile(pct=50).publish(label='D')
        E = (A).percentile(pct=90).publish(label='E')
        F = (A).max().publish(label='F')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 900
  unit_prefix        = "Metric"

  axis_left {
    label = "Requests"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "A - Maximum"
    label        = "F"
  }
  viz_options {
    axis         = "left"
    display_name = "A - Minimum"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "A - P10"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    display_name = "A - P50"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    display_name = "A - P90"
    label        = "E"
  }
  viz_options {
    axis         = "left"
    display_name = "diskIO.avgQueueLen"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_rds_enhanced_instances_top_latency" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top 5 DBs by Response Latency"
  program_text            = "A = data('diskIO.await').top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"

  legend_options_fields {
    enabled  = false
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = true
    property = "device"
  }
  legend_options_fields {
    enabled  = false
    property = "EngineName"
  }
  legend_options_fields {
    enabled  = true
    property = "instanceResourceID"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_originatingMetric"
  }
  legend_options_fields {
    enabled  = false
    property = "Namespace"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_metric"
  }

  viz_options {
    display_name = "diskIO.await - Top 5"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_instances_latency" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Average Latency (all requests)"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('diskIO.await').publish(label='A', enable=False)
        B = (A).min().publish(label='B')
        C = (A).percentile(pct=10).publish(label='C')
        D = (A).percentile(pct=50).publish(label='D')
        E = (A).percentile(pct=90).publish(label='E')
        F = (A).max().publish(label='F')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 900
  unit_prefix        = "Metric"

  axis_left {
    label = "ms"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "A - Maximum"
    label        = "F"
  }
  viz_options {
    axis         = "left"
    display_name = "A - Minimum"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "A - P10"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    display_name = "A - P50"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    display_name = "A - P90"
    label        = "E"
  }
  viz_options {
    axis         = "left"
    display_name = "diskIO.await"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_instances_mem" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "% Active Memory"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('memory.active', filter=(not filter('EngineName', 'Aurora'))).publish(label='A', enable=False)
        B = data('memory.total', filter=(not filter('EngineName', 'Aurora'))).publish(label='B', enable=False)
        I = (A/B).scale(100).publish(label='I', enable=False)
        C = (I).min().publish(label='C')
        D = (I).percentile(pct=10).publish(label='D')
        E = (I).percentile(pct=50).publish(label='E')
        F = (I).percentile(pct=90).publish(label='F')
        G = (I).max().publish(label='G')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 900
  unit_prefix        = "Metric"

  axis_left {
    label     = "% Active Memory"
    max_value = 100
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "% Active Memory - Maximum"
    label        = "G"
  }
  viz_options {
    axis         = "left"
    display_name = "% Active Memory - Minimum"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    display_name = "% Active Memory - P10"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    display_name = "% Active Memory - P50"
    label        = "E"
  }
  viz_options {
    axis         = "left"
    display_name = "% Active Memory - P90"
    label        = "F"
  }
  viz_options {
    axis         = "left"
    display_name = "A/B - Scale:100"
    label        = "I"
  }
  viz_options {
    axis         = "left"
    display_name = "memory.active"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    display_name = "memory.total"
    label        = "B"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_instances_storage" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "% Storage Used"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('fileSys.usedPercent', filter=(not filter('EngineName', 'Aurora'))).publish(label='A', enable=False)
        B = (A).min().publish(label='B')
        C = (A).percentile(pct=10).publish(label='C')
        D = (A).percentile(pct=50).publish(label='D')
        E = (A).percentile(pct=90).publish(label='E')
        F = (A).max().publish(label='F')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 900
  unit_prefix        = "Metric"

  axis_left {
    label = "% Total Storage Used"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "Maximum"
    label        = "F"
  }
  viz_options {
    axis         = "left"
    display_name = "Minimum"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "P10"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    display_name = "P50"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    display_name = "P90"
    label        = "E"
  }
  viz_options {
    axis         = "left"
    display_name = "fileSys.usedPercent"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_rds_enhanced_instances_top_storage" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top 5 DBs by % Storage Used"
  program_text            = "A = data('fileSys.usedPercent', filter=(not filter('EngineName', 'Aurora'))).top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"

  legend_options_fields {
    enabled  = false
    property = "AWSUniqueId"
  }
  legend_options_fields {
    enabled  = false
    property = "EngineName"
  }
  legend_options_fields {
    enabled  = true
    property = "instanceResourceID"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_originatingMetric"
  }
  legend_options_fields {
    enabled  = true
    property = "mountPoint"
  }
  legend_options_fields {
    enabled  = true
    property = "name"
  }
  legend_options_fields {
    enabled  = false
    property = "Namespace"
  }
  legend_options_fields {
    enabled  = false
    property = "sf_metric"
  }

  viz_options {
    display_name = "fileSys.usedPercent - Top 5"
    label        = "A"
  }
}

resource "signalfx_dashboard" "sfx_aws_rds_enhanced_instances" {

  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.sfx_aws_rds_enhanced.id
  description       = "A curated overview of all monitored RDS instances (excluding SQL Server instances)."
  name              = "Enhanced RDS Instances"

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_rds_enhanced_instances_count.id
    row      = 0
    column   = 0
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_rds_enhanced_instances_by_engine.id
    row      = 0
    column   = 3
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_instances_cpu.id
    row      = 0
    column   = 6
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_rds_enhanced_instances_top_cpu.id
    row      = 0
    column   = 9
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_instances_reads.id
    row      = 1
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_instances_reads_thru.id
    row      = 1
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_rds_enhanced_instances_top_reads.id
    row      = 2
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_rds_enhanced_instances_top_reads_thru.id
    row      = 2
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_instances_writes.id
    row      = 3
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_instances_writes_thru.id
    row      = 3
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_rds_enhanced_instances_top_writes.id
    row      = 4
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_rds_enhanced_instances_top_writes_thru.id
    row      = 4
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_instances_net_bytes.id
    row      = 5
    column   = 0
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_instances_queue_len.id
    row      = 5
    column   = 3
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_instances_latency.id
    row      = 5
    column   = 6
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_rds_enhanced_instances_top_latency.id
    row      = 5
    column   = 9
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_instances_mem.id
    row      = 6
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_instances_storage.id
    row      = 6
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_rds_enhanced_instances_top_storage.id
    row      = 6
    column   = 8
    height   = 1
    width    = 4
  }

}
