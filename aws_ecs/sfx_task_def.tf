resource "signalfx_single_value_chart" "sfx_aws_ecs_sfx_task_def_tasks_count" {
  color_by                = "Dimension"
  max_precision           = 0
  name                    = "# Running Tasks"
  program_text            = "B = data('cpu.usage.total', filter=filter('ClusterName', '*', match_missing=True) and filter('ecs_task_group', '*', match_missing=True)).sum(by=['ecs_task_arn']).count().publish(label='B')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "cpu.usage.total - Sum by ecs_task_arn - Count"
    label        = "B"
  }
}

resource "signalfx_time_chart" "sfx_aws_ecs_sfx_task_def_tasks" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "# Running Tasks"
  plot_type          = "AreaChart"
  program_text       = "B = data('cpu.usage.total', filter=filter('ClusterName', '*') and filter('ecs_task_group', '*')).sum(by=['ecs_task_arn']).count().publish(label='B')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 900
  unit_prefix        = "Metric"

  axis_left {
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "# Running Tasks"
    label        = "B"
  }
}

resource "signalfx_time_chart" "sfx_aws_ecs_sfx_task_def_cpu_pct" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "per container"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "CPU %"
  plot_type          = "LineChart"
  program_text       = <<-EOF
        A = data('cpu.usage.total', filter=filter('ecs_task_group', '*'), rollup='rate').publish(label='A', enable=False)
        B = data('cpu.usage.system', filter=filter('ecs_task_group', '*'), rollup='rate').publish(label='B', enable=False)
        C = ((A/B)*100).mean(by=['container_name']).publish(label='C')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "cpu %"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "CPU Usage per Container"
    label        = "C"
    value_suffix = "%"
  }
  viz_options {
    axis         = "left"
    display_name = "cpu usage system"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "cpu usage total"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_ecs_sfx_task_def_mem_pct" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "per container"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Memory %"
  plot_type          = "LineChart"
  program_text       = <<-EOF
        A = data('memory.usage.total', filter=filter('ecs_task_group', '*'), extrapolation='last_value', maxExtrapolations=5).publish(label='A', enable=False)
        B = data('memory.usage.limit', filter=filter('ecs_task_group', '*')).publish(label='B', enable=False)
        C = ((A/B)*100).mean(by=['container_name']).publish(label='C')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "memory %"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "Memory Limits"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "Memory Usage %"
    label        = "C"
    value_suffix = "%"
  }
  viz_options {
    axis         = "left"
    display_name = "Memory Usage"
    label        = "A"
  }
}

resource "signalfx_dashboard" "sfx_aws_ecs_sfx_task_def" {

  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.sfx_aws_ecs.id
  name              = "ECS (SignalFx) Task Definition"

  variable {
    alias                  = "Cluster"
    apply_if_exist         = false
    description            = "ECS cluster"
    property               = "ClusterName"
    replace_only           = true
    restricted_suggestions = false
    value_required         = false
    values                 = []
    values_suggested       = []
  }
  variable {
    alias                  = "Task Definition"
    apply_if_exist         = false
    property               = "ecs_task_group"
    replace_only           = true
    restricted_suggestions = false
    value_required         = false
    values                 = []
    values_suggested       = []
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_ecs_sfx_task_def_tasks_count.id
    row      = 0
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_ecs_sfx_task_def_tasks.id
    row      = 0
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_ecs_sfx_task_def_cpu_pct.id
    row      = 1
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_ecs_sfx_task_def_mem_pct.id
    row      = 1
    column   = 6
    height   = 1
    width    = 6
  }

}
