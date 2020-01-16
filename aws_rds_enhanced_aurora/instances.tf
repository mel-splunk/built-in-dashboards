resource "signalfx_single_value_chart" "sfx_aws_rds_enhanced_aurora_instances_0" {
  color_by                = "Dimension"
  is_timestamp_hidden     = false
  max_precision           = 0
  name                    = "# DB Instances"
  program_text            = "A = data('cpuUtilization.total', filter=filter('EngineName', 'Aurora')).count().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "cpuUtilization.total - Count"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_aurora_instances_1" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Total CPU %"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('cpuUtilization.total', filter=filter('EngineName', 'Aurora')).publish(label='A', enable=False)
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

resource "signalfx_list_chart" "sfx_aws_rds_enhanced_aurora_instances_2" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top 5 DBs by CPU %"
  program_text            = "A = data('cpuUtilization.total', filter=filter('EngineName', 'Aurora')).top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"

  viz_options {
    display_name = "cpuUtilization.total - Top 5"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_aurora_instances_3" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "ReadIOs/sec"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('diskIO.readIOsPS', filter=filter('EngineName', 'Aurora')).publish(label='A', enable=False)
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

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_aurora_instances_4" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Read Throughput"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('diskIO.readThroughput').publish(label='A', enable=False)
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
    display_name = "diskIO.readThroughput"
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

resource "signalfx_list_chart" "sfx_aws_rds_enhanced_aurora_instances_5" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top 5 DBs by ReadIOs/sec"
  program_text            = "A = data('diskIO.readIOsPS', filter=filter('EngineName', 'Aurora')).top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"

  viz_options {
    display_name = "ReadIOs/sec"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_rds_enhanced_aurora_instances_6" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top 5 DBs by Read Throughput"
  program_text            = "A = data('diskIO.readThroughput').top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"

  viz_options {
    display_name = "diskIO.readThroughput - Top 5"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_aurora_instances_7" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "WriteIOs/sec"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('diskIO.writeIOsPS', filter=filter('EngineName', 'Aurora')).publish(label='A', enable=False)
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

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_aurora_instances_8" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Write Throughput"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('diskIO.writeThroughput').publish(label='A', enable=False)
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
    display_name = "diskIO.writeThroughput"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_rds_enhanced_aurora_instances_9" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top 5 DBs by WriteIOs/sec"
  program_text            = "A = data('diskIO.writeIOsPS', filter=filter('EngineName', 'Aurora')).top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"

  viz_options {
    display_name = "WriteIOs/sec"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_rds_enhanced_aurora_instances_10" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top 5 DBs by Write Throughput"
  program_text            = "A = data('diskIO.writeThroughput').top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"

  viz_options {
    display_name = "diskIO.writeThroughput - Top 5"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_aurora_instances_11" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Network Traffic (bytes/sec)"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('network.tx', filter=filter('EngineName', 'Aurora')).publish(label='A', enable=False)
        G = data('network.rx', filter=filter('EngineName', 'Aurora')).publish(label='G', enable=False)
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
    label        = "G"
  }
  viz_options {
    axis         = "left"
    display_name = "network.tx"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_aurora_instances_12" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Average Queue Length"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('diskIO.diskQueueDepth').publish(label='A', enable=False)
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
    display_name = "diskIO.diskQueueDepth"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_aurora_instances_13" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Read Latency"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('diskIO.readLatency').publish(label='A', enable=False)
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
    display_name = "diskIO.readLatency"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_aurora_instances_14" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Write Latency"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('diskIO.writeLatency').publish(label='A', enable=False)
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
    display_name = "diskIO.writeLatency"
    label        = "A"
  }
}

# signalfx_list_chart.sfx_aws_rds_enhanced_aurora_instances_15:
resource "signalfx_list_chart" "sfx_aws_rds_enhanced_aurora_instances_15" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top 5 DBs by Read Latency"
  program_text            = "A = data('diskIO.readLatency').top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"

  viz_options {
    display_name = "diskIO.readLatency - Top 5"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_rds_enhanced_aurora_instances_16" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top 5 DBs by Write Latency"
  program_text            = "A = data('diskIO.writeLatency').top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"

  viz_options {
    display_name = "diskIO.writeLatency - Top 5"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_aurora_instances_17" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "% Active Memory"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('memory.active', filter=filter('EngineName', 'Aurora')).publish(label='A', enable=False)
        B = data('memory.total', filter=filter('EngineName', 'Aurora')).publish(label='B', enable=False)
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

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_aurora_instances_18" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "% Storage Used"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('fileSys.usedPercent', filter=filter('EngineName', 'Aurora')).publish(label='A', enable=False)
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

resource "signalfx_list_chart" "sfx_aws_rds_enhanced_aurora_instances_19" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top 5 DBs by % Storage Used"
  program_text            = "A = data('fileSys.usedPercent', filter=filter('EngineName', 'Aurora')).top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"

  viz_options {
    display_name = "fileSys.usedPercent - Top 5"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_rds_enhanced_aurora_instances_20" {
  color_by                = "Metric"
  disable_sampling        = false
  max_precision           = 0
  name                    = "% Total DB Tasks by State"
  program_text            = <<-EOF
        A = data('tasks.blocked').sum().publish(label='A', enable=False)
        B = data('tasks.running').sum().publish(label='B', enable=False)
        C = data('tasks.sleeping').sum().publish(label='C', enable=False)
        D = data('tasks.stopped').sum().publish(label='D', enable=False)
        F = data('tasks.zombie').sum().publish(label='F', enable=False)
        G = data('tasks.total').sum().publish(label='G', enable=False)
        H = ((A/G)*100).publish(label='H')
        I = ((B/G)*100).publish(label='I')
        J = ((C/G)*100).publish(label='J')
        K = ((D/G)*100).publish(label='K')
        L = ((F/G)*100).publish(label='L')
    EOF
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"

  viz_options {
    display_name = "% Blocked Tasks"
    label        = "H"
  }
  viz_options {
    display_name = "% Running Tasks"
    label        = "I"
  }
  viz_options {
    display_name = "% Sleeping Tasks"
    label        = "J"
  }
  viz_options {
    display_name = "% Stopped Tasks"
    label        = "K"
  }
  viz_options {
    display_name = "% Zombie Tasks"
    label        = "L"
  }
  viz_options {
    display_name = "tasks.blocked - Sum"
    label        = "A"
  }
  viz_options {
    display_name = "tasks.running - Sum"
    label        = "B"
  }
  viz_options {
    display_name = "tasks.sleeping - Sum"
    label        = "C"
  }
  viz_options {
    display_name = "tasks.stopped - Sum"
    label        = "D"
  }
  viz_options {
    display_name = "tasks.total - Sum"
    label        = "G"
  }
  viz_options {
    display_name = "tasks.zombie - Sum"
    label        = "F"
  }
}

resource "signalfx_dashboard" "sfx_aws_rds_enhanced_aurora_instances" {

  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.sfx_aws_rds_enhanced_aurora.id
  name              = "Enhanced RDS Instances - Aurora"

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_rds_enhanced_aurora_instances_0.id
    row      = 0
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_aurora_instances_1.id
    row      = 0
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_rds_enhanced_aurora_instances_2.id
    row      = 0
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_aurora_instances_3.id
    row      = 1
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_aurora_instances_4.id
    row      = 1
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_rds_enhanced_aurora_instances_5.id
    row      = 2
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_rds_enhanced_aurora_instances_6.id
    row      = 2
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_aurora_instances_7.id
    row      = 3
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_aurora_instances_8.id
    row      = 3
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_rds_enhanced_aurora_instances_9.id
    row      = 4
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_rds_enhanced_aurora_instances_10.id
    row      = 4
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_aurora_instances_11.id
    row      = 5
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_aurora_instances_12.id
    row      = 5
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_aurora_instances_13.id
    row      = 6
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_aurora_instances_14.id
    row      = 6
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_rds_enhanced_aurora_instances_15.id
    row      = 7
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_rds_enhanced_aurora_instances_16.id
    row      = 7
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_aurora_instances_17.id
    row      = 8
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_aurora_instances_18.id
    row      = 8
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_rds_enhanced_aurora_instances_19.id
    row      = 8
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_rds_enhanced_aurora_instances_20.id
    row      = 9
    column   = 8
    height   = 1
    width    = 4
  }

}
