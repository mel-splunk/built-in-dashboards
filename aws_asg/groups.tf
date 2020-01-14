resource "signalfx_single_value_chart" "sfx_aws_asg_groups_count" {
  color_by                = "Dimension"
  max_precision           = 0
  name                    = "# AutoScaling Groups"
  program_text            = "A = data('GroupTotalInstances', filter=filter('stat', 'mean') and filter('namespace', 'AWS/AutoScaling')).count(by=['AutoScalingGroupName']).sum().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "GroupTotalInstances - Count by AutoScalingGroupName - Sum"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_asg_groups_instance_count" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Total # Instances"
  plot_type          = "LineChart"
  program_text       = "A = data('GroupTotalInstances', filter=filter('stat', 'mean') and filter('namespace', 'AWS/AutoScaling')).mean(by=['AutoScalingGroupName']).sum().publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "GroupTotalInstances - Mean by AutoScalingGroupName - Sum"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_asg_groups_top_group_by_instances" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top Groups by # Instances"
  program_text            = "A = data('GroupTotalInstances', filter=filter('stat', 'mean') and filter('namespace', 'AWS/AutoScaling')).mean(by=['AutoScalingGroupName']).top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  unit_prefix             = "Metric"

  viz_options {
    label = "A"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_asg_groups_in_service_count" {
  color_by                = "Dimension"
  max_precision           = 0
  name                    = "In Service Instances"
  program_text            = "A = data('GroupInServiceInstances', filter=filter('stat', 'mean') and filter('namespace', 'AWS/AutoScaling')).mean(by=['AutoScalingGroupName']).sum().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "GroupInServiceInstances - Mean by AutoScalingGroupName - Sum"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_asg_groups_in_service" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "In Service Instances per Period"
  plot_type          = "AreaChart"
  program_text       = "A = data('GroupInServiceInstances', filter=filter('stat', 'mean') and filter('namespace', 'AWS/AutoScaling')).mean(by=['AutoScalingGroupName']).sum().publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "# instances"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "GroupInServiceInstances - Mean by AutoScalingGroupName - Sum"
    label        = "A"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_asg_groups_pending_count" {
  color_by                = "Dimension"
  max_precision           = 0
  name                    = "Total Pending Instances"
  program_text            = "A = data('GroupPendingInstances', filter=filter('stat', 'mean') and filter('namespace', 'AWS/AutoScaling')).mean(by=['AutoScalingGroupName']).sum().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "GroupPendingInstances - Mean by AutoScalingGroupName - Sum"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_asg_groups_pending" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Total Pending Instances per Interval"
  plot_type          = "AreaChart"
  program_text       = "A = data('GroupPendingInstances', filter=filter('namespace', 'AWS/AutoScaling') and filter('stat', 'mean')).mean(by=['AutoScalingGroupName']).sum().publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "# instances"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "GroupPendingInstances - Mean by AutoScalingGroupName - Sum"
    label        = "A"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_asg_groups_terminating_count" {
  color_by                = "Dimension"
  max_precision           = 0
  name                    = "Total Terminating Instances"
  program_text            = "A = data('GroupTerminatingInstances', filter=filter('stat', 'mean') and filter('namespace', 'AWS/AutoScaling')).mean(by=['AutoScalingGroupName']).sum().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "GroupTerminatingInstances - Mean by AutoScalingGroupName - Sum"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_asg_groups_terminating" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Total Terminating Instances per Period"
  plot_type          = "AreaChart"
  program_text       = "A = data('GroupTerminatingInstances', filter=filter('stat', 'mean') and filter('namespace', 'AWS/AutoScaling')).mean(by=['AutoScalingGroupName']).sum().publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "# instances"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "GroupTerminatingInstances - Mean by AutoScalingGroupName - Sum"
    label        = "A"
  }
}

resource "signalfx_dashboard" "sfx_aws_asg_groups" {
  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.sfx_aws_asg.id
  name              = "AutoScaling - Multi Group"

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_asg_groups_count.id
    row      = 0
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_asg_groups_instance_count.id
    row      = 0
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_asg_groups_top_group_by_instances.id
    row      = 0
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_asg_groups_in_service_count.id
    row      = 1
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_asg_groups_in_service.id
    row      = 1
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_asg_groups_pending_count.id
    row      = 2
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_asg_groups_pending.id
    row      = 2
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_asg_groups_terminating_count.id
    row      = 3
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_asg_groups_terminating.id
    row      = 3
    column   = 6
    height   = 1
    width    = 6
  }

}
