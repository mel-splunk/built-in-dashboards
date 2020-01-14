resource "signalfx_single_value_chart" "sfx_aws_ecs_aws_active_clusters" {
  color_by                = "Dimension"
  max_precision           = 0
  name                    = "# Active Clusters"
  program_text            = "A = data('CPUReservation', filter=filter('namespace', 'AWS/ECS'), extrapolation='last_value', maxExtrapolations=5).mean(by=['ClusterName']).count().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "A"
    label        = "A"
    value_suffix = "clusters"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_ecs_aws_running_clusters" {
  color_by                = "Dimension"
  max_precision           = 0
  name                    = "# Running Services"
  program_text            = "A = data('CPUUtilization', filter=filter('ClusterName', '*') and filter('ServiceName', '*') and filter('stat', 'mean') and filter('namespace', 'AWS/ECS'), extrapolation='last_value', maxExtrapolations=5).count(by=['ClusterName', 'ServiceName']).sum().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "CPUUtilization - Count by ClusterName,ServiceName - Sum"
    label        = "A"
    value_suffix = "services"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_ecs_aws_running_tasks" {
  color_by                = "Dimension"
  max_precision           = 0
  name                    = "# Running Tasks"
  program_text            = "A = data('CPUUtilization', filter=filter('namespace', 'AWS/ECS') and filter('ServiceName', '*') and filter('stat', 'count'), rollup='average', extrapolation='last_value', maxExtrapolations=5).sum().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "A"
    label        = "A"
    value_suffix = "tasks"
  }
}

resource "signalfx_list_chart" "sfx_aws_ecs_aws_top_cpu" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 3
  name                    = "Top Clusters by CPU %"
  program_text            = "A = data('CPUUtilization', filter=filter('namespace', 'AWS/ECS') and filter('stat', 'mean') and (not filter('ServiceName', '*')), extrapolation='last_value', maxExtrapolations=5).mean(by=['ClusterName']).top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  unit_prefix             = "Metric"
}

resource "signalfx_list_chart" "sfx_aws_ecs_aws_top_memory" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 3
  name                    = "Top Clusters by Memory %"
  program_text            = "A = data('MemoryUtilization', filter=filter('namespace', 'AWS/ECS') and filter('stat', 'mean') and (not filter('ServiceName', '*')), extrapolation='last_value', maxExtrapolations=5).mean(by=['ClusterName']).top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  unit_prefix             = "Metric"
}

resource "signalfx_time_chart" "sfx_aws_ecs_aws_running_tasks_by_cluster" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "# Running Tasks by Cluster"
  plot_type          = "AreaChart"
  program_text       = "A = data('CPUUtilization', filter=filter('namespace', 'AWS/ECS') and filter('ServiceName', '*') and filter('stat', 'count'), rollup='average').sum(by=['ClusterName']).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = true
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "# tasks"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "# running tasks"
    label        = "A"
    value_suffix = "tasks"
  }
}

resource "signalfx_time_chart" "sfx_aws_ecs_aws_running_services_by_cluster" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "# Running Services by Cluster"
  plot_type          = "AreaChart"
  program_text       = "A = data('CPUUtilization', filter=filter('namespace', 'AWS/ECS') and filter('ClusterName', '*') and filter('ServiceName', '*') and filter('stat', 'mean')).mean(by=['ClusterName', 'ServiceName']).count(by=['ClusterName']).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = true
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "# services"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "# running services"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_ecs_aws_top_cpu_by_services" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 3
  name                    = "Top Services by CPU %"
  program_text            = "A = data('CPUUtilization', filter=filter('namespace', 'AWS/ECS') and filter('stat', 'mean') and filter('ServiceName', '*')).mean(by=['ServiceName', 'ClusterName']).top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  unit_prefix             = "Metric"

  viz_options {
    label = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_ecs_aws_top_memory_by_services" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 3
  name                    = "Top Services by Memory %"
  program_text            = "A = data('MemoryUtilization', filter=filter('stat', 'mean') and filter('namespace', 'AWS/ECS') and filter('ServiceName', '*')).sum(by=['ServiceName', 'ClusterName']).top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  time_range              = 900
  unit_prefix             = "Metric"

  viz_options {
    label = "A"
  }
}

resource "signalfx_dashboard" "sfx_aws_ecs_aws" {
  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.sfx_aws_ecs.id
  name              = "ECS (AWS)"

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_ecs_aws_active_clusters.id
    row      = 0
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_ecs_aws_running_clusters.id
    row      = 0
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_ecs_aws_running_tasks.id
    row      = 0
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_ecs_aws_top_cpu.id
    row      = 1
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_ecs_aws_top_memory.id
    row      = 1
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_ecs_aws_running_tasks_by_cluster.id
    row      = 2
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_ecs_aws_running_services_by_cluster.id
    row      = 2
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_ecs_aws_top_cpu_by_services.id
    row      = 3
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_ecs_aws_top_memory_by_services.id
    row      = 3
    column   = 6
    height   = 1
    width    = 6
  }
}
