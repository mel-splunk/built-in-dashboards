resource "signalfx_single_value_chart" "sfx_aws_rds_enhanced_aurora_instance_0" {
  color_by                = "Dimension"
  is_timestamp_hidden     = false
  max_precision           = 0
  name                    = "Total CPU Utilization"
  program_text            = "A = data('cpuUtilization.total', filter=filter('EngineName', 'Aurora')).publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "cpuUtilization.total"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_aurora_instance_1" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "% CPU Utilization by Use Category"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('cpuUtilization.guest', filter=filter('EngineName', 'Aurora')).publish(label='A')
        B = data('cpuUtilization.idle', filter=filter('EngineName', 'Aurora')).publish(label='B')
        C = data('cpuUtilization.irq', filter=filter('EngineName', 'Aurora')).publish(label='C')
        D = data('cpuUtilization.nice', filter=filter('EngineName', 'Aurora')).publish(label='D')
        E = data('cpuUtilization.steal', filter=filter('EngineName', 'Aurora')).publish(label='E')
        F = data('cpuUtilization.system', filter=filter('EngineName', 'Aurora')).publish(label='F')
        G = data('cpuUtilization.user', filter=filter('EngineName', 'Aurora')).publish(label='G')
        H = data('cpuUtilization.wait', filter=filter('EngineName', 'Aurora')).publish(label='H')
    EOF
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
    display_name = "% idle"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "% in use by interrupts"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    display_name = "% in use by kernel"
    label        = "F"
  }
  viz_options {
    axis         = "left"
    display_name = "% in use by other VMs"
    label        = "E"
  }
  viz_options {
    axis         = "left"
    display_name = "% in use by programs at lowest priority"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    display_name = "% in use by user programs"
    label        = "G"
  }
  viz_options {
    axis         = "left"
    display_name = "% unused while waiting for I/O access"
    label        = "H"
  }
  viz_options {
    axis         = "left"
    display_name = "% used by guest programs"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_aurora_instance_2" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Task Status Breakdown"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('tasks.blocked', filter=filter('EngineName', 'Aurora')).publish(label='A')
        B = data('tasks.running', filter=filter('EngineName', 'Aurora')).publish(label='B')
        C = data('tasks.sleeping', filter=filter('EngineName', 'Aurora')).publish(label='C')
        D = data('tasks.stopped', filter=filter('EngineName', 'Aurora')).publish(label='D')
        E = data('tasks.zombie', filter=filter('EngineName', 'Aurora')).publish(label='E')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = true
  time_range         = 900
  unit_prefix        = "Metric"

  axis_left {
    label     = "# Tasks"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "tasks.blocked"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    display_name = "tasks.running"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "tasks.sleeping"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    display_name = "tasks.stopped"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    display_name = "tasks.zombie"
    label        = "E"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_aurora_instance_3" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Read/WriteIOs/sec"
  plot_type          = "LineChart"
  program_text       = <<-EOF
        A = data('diskIO.writeIOsPS', filter=filter('EngineName', 'Aurora')).publish(label='A')
        B = data('diskIO.readIOsPS', filter=filter('EngineName', 'Aurora')).publish(label='B')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 900
  unit_prefix        = "Metric"

  axis_left {
    label = "Read ops/sec - YELLOW"
  }

  axis_right {
    label = "Write ops/sec - BLUE"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    color        = "yellow"
    display_name = "diskIO.readIOsPS"
    label        = "B"
  }
  viz_options {
    axis         = "right"
    color        = "blue"
    display_name = "diskIO.writeIOsPS"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_aurora_instance_4" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Read/Write Throughput"
  plot_type          = "ColumnChart"
  program_text       = <<-EOF
        A = data('diskIO.readThroughput').publish(label='A')
        B = data('diskIO.writeThroughput').publish(label='B')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 900
  unit_prefix        = "Metric"

  axis_left {
    label = "Read - kb/sec - ORANGE"
  }

  axis_right {
    label = "Write - kb/sec - GREEN"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    color        = "orange"
    display_name = "diskIO.readThroughput"
    label        = "A"
  }
  viz_options {
    axis         = "right"
    color        = "green"
    display_name = "diskIO.writeThroughput"
    label        = "B"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_aurora_instance_5" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Read Latency"
  plot_type          = "AreaChart"
  program_text       = "A = data('diskIO.readLatency').publish(label='A')"
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
    display_name = "diskIO.readLatency"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_aurora_instance_6" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Write Latency"
  plot_type          = "AreaChart"
  program_text       = "A = data('diskIO.writeLatency').publish(label='A')"
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
    display_name = "diskIO.writeLatency"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_aurora_instance_7" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Average Queue Length"
  plot_type          = "AreaChart"
  program_text       = "A = data('diskIO.diskQueueDepth').publish(label='A')"
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
    color        = "emerald"
    display_name = "diskIO.diskQueueDepth"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_aurora_instance_8" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Memory Usage"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('memory.free', filter=filter('EngineName', 'Aurora')).scale(0.001).publish(label='A')
        B = data('memory.active', filter=filter('EngineName', 'Aurora')).scale(0.001).publish(label='B')
        C = data('memory.buffers', filter=filter('EngineName', 'Aurora')).scale(0.001).publish(label='C')
        D = data('memory.inactive', filter=filter('EngineName', 'Aurora')).scale(0.001).publish(label='D')
        E = data('memory.mapped', filter=filter('EngineName', 'Aurora')).scale(0.001).publish(label='E')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = true
  time_range         = 900
  unit_prefix        = "Metric"

  axis_left {
    label = "MB"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "memory.active - Scale:0.001"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "memory.buffers - Scale:0.001"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    display_name = "memory.free - Scale:0.001"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    display_name = "memory.inactive - Scale:0.001"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    display_name = "memory.mapped - Scale:0.001"
    label        = "E"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_aurora_instance_9" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Storage Usage"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('fileSys.total', filter=filter('EngineName', 'Aurora')).publish(label='A', enable=False)
        B = data('fileSys.used', filter=filter('EngineName', 'Aurora')).publish(label='B')
        C = (A-B).publish(label='C')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = true
  time_range         = 900
  unit_prefix        = "Metric"

  axis_left {
    label = "kb"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "fileSys.total"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    display_name = "free storage"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    display_name = "used storage"
    label        = "B"
  }
}

resource "signalfx_time_chart" "sfx_aws_rds_enhanced_aurora_instance_10" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Network IO"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('network.tx', filter=filter('EngineName', 'Aurora')).publish(label='A')
        B = data('network.rx', filter=filter('EngineName', 'Aurora')).publish(label='B')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 900
  unit_prefix        = "Metric"

  axis_left {
    label = "Read - bytes/sec - RED"
  }

  axis_right {
    label = "Write - bytes/sec - GREEN"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    color        = "purple"
    display_name = "network.rx"
    label        = "B"
  }
  viz_options {
    axis         = "right"
    color        = "green"
    display_name = "network.tx"
    label        = "A"
  }
}

resource "signalfx_dashboard" "sfx_aws_rds_enhanced_aurora_instance" {

  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.sfx_aws_rds_enhanced_aurora.id
  name              = "Enhanced RDS Instance - Aurora"

  variable {
    alias                  = "instance"
    apply_if_exist         = false
    description            = "null"
    property               = "AWSUniqueId"
    replace_only           = false
    restricted_suggestions = false
    value_required         = false
    values                 = []
    values_suggested       = []
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_rds_enhanced_aurora_instance_0.id
    row      = 0
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_aurora_instance_1.id
    row      = 0
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_aurora_instance_2.id
    row      = 0
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_aurora_instance_3.id
    row      = 1
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_aurora_instance_4.id
    row      = 1
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_aurora_instance_5.id
    row      = 2
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_aurora_instance_6.id
    row      = 2
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_aurora_instance_7.id
    row      = 2
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_aurora_instance_8.id
    row      = 3
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_aurora_instance_9.id
    row      = 3
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_rds_enhanced_aurora_instance_10.id
    row      = 3
    column   = 8
    height   = 1
    width    = 4
  }

}
