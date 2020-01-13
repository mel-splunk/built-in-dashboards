resource "signalfx_single_value_chart" "sfx_aws_asg_group_min_size" {
    color_by                = "Dimension"
    max_precision           = 0
    name                    = "GroupMinSize"
    program_text            = "A = data('GroupMinSize', filter=filter('stat', 'mean') and filter('namespace', 'AWS/AutoScaling') and filter('AutoScalingGroupName', 'EC2ContainerService-default-439766bb-17a3-41cb-9e17-134df785fafe-EcsInstanceAsg-ZI6N93VA0FRE')).publish(label='A')"
    secondary_visualization = "None"
    show_spark_line         = false
    unit_prefix             = "Metric"

    viz_options {
        display_name = "GroupMinSize"
        label        = "A"
    }
}

resource "signalfx_single_value_chart" "sfx_aws_asg_group_max_size" {
    color_by                = "Dimension"
    max_precision           = 0
    name                    = "GroupMaxSize"
    program_text            = "A = data('GroupMaxSize', filter=filter('stat', 'mean') and filter('namespace', 'AWS/AutoScaling') and filter('AutoScalingGroupName', 'EC2ContainerService-default-439766bb-17a3-41cb-9e17-134df785fafe-EcsInstanceAsg-ZI6N93VA0FRE')).publish(label='A')"
    secondary_visualization = "None"
    show_spark_line         = false
    unit_prefix             = "Metric"

    viz_options {
        display_name = "GroupMaxSize"
        label        = "A"
    }
}

resource "signalfx_single_value_chart" "sfx_aws_asg_group_desired_cap" {
    color_by                = "Dimension"
    max_precision           = 2
    name                    = "GroupDesiredCapacity"
    program_text            = "A = data('GroupDesiredCapacity', filter=filter('stat', 'mean') and filter('AutoScalingGroupName', 'EC2ContainerService-default-439766bb-17a3-41cb-9e17-134df785fafe-EcsInstanceAsg-ZI6N93VA0FRE')).publish(label='A')"
    secondary_visualization = "None"
    show_spark_line         = false
    unit_prefix             = "Metric"

    viz_options {
        display_name = "GroupDesiredCapacity"
        label        = "A"
    }
}

resource "signalfx_single_value_chart" "sfx_aws_asg_group_in_service_count" {
    color_by                = "Dimension"
    max_precision           = 0
    name                    = "In Service Instances"
    program_text            = "A = data('GroupInServiceInstances', filter=filter('stat', 'mean') and filter('namespace', 'AWS/AutoScaling') and filter('AutoScalingGroupName', 'EC2ContainerService-default-439766bb-17a3-41cb-9e17-134df785fafe-EcsInstanceAsg-ZI6N93VA0FRE')).publish(label='A')"
    secondary_visualization = "None"
    show_spark_line         = false
    unit_prefix             = "Metric"

    viz_options {
        display_name = "GroupInServiceInstances"
        label        = "A"
    }
}

resource "signalfx_time_chart" "sfx_aws_asg_group_in_service" {
    axes_include_zero  = false
    axes_precision     = 0
    color_by           = "Dimension"
    disable_sampling   = false
    minimum_resolution = 0
    name               = "In Service Instances per Period"
    plot_type          = "AreaChart"
    program_text       = "A = data('GroupInServiceInstances', filter=filter('stat', 'mean') and filter('namespace', 'AWS/AutoScaling') and filter('AutoScalingGroupName', 'EC2ContainerService-default-439766bb-17a3-41cb-9e17-134df785fafe-EcsInstanceAsg-ZI6N93VA0FRE')).publish(label='A')"
    show_data_markers  = false
    show_event_lines   = false
    stacked            = false
    time_range         = 7200
    unit_prefix        = "Metric"

    axis_left {
        label          = "# instances"
        min_value      = 0
    }

    histogram_options {
        color_theme = "red"
    }

    viz_options {
        axis         = "left"
        display_name = "GroupInServiceInstances"
        label        = "A"
    }
}

resource "signalfx_single_value_chart" "sfx_aws_asg_group_pending_count" {
    color_by                = "Dimension"
    max_precision           = 0
    name                    = "Total Pending Instances"
    program_text            = "A = data('GroupPendingInstances', filter=filter('stat', 'mean') and filter('namespace', 'AWS/AutoScaling') and filter('AutoScalingGroupName', 'EC2ContainerService-default-439766bb-17a3-41cb-9e17-134df785fafe-EcsInstanceAsg-ZI6N93VA0FRE')).publish(label='A')"
    secondary_visualization = "None"
    show_spark_line         = false
    unit_prefix             = "Metric"

    viz_options {
        display_name = "GroupPendingInstances"
        label        = "A"
    }
}

resource "signalfx_time_chart" "sfx_aws_asg_group_pending" {
    axes_include_zero  = false
    axes_precision     = 0
    color_by           = "Dimension"
    disable_sampling   = false
    minimum_resolution = 0
    name               = "Total Pending Instances per Interval"
    plot_type          = "AreaChart"
    program_text       = "A = data('GroupPendingInstances', filter=filter('namespace', 'AWS/AutoScaling') and filter('stat', 'mean') and filter('AutoScalingGroupName', 'EC2ContainerService-default-439766bb-17a3-41cb-9e17-134df785fafe-EcsInstanceAsg-ZI6N93VA0FRE')).publish(label='A')"
    show_data_markers  = false
    show_event_lines   = false
    stacked            = false
    time_range         = 7200
    unit_prefix        = "Metric"

    axis_left {
        label          = "# instances"
        min_value      = 0
    }

    histogram_options {
        color_theme = "red"
    }

    viz_options {
        axis         = "left"
        display_name = "GroupPendingInstances"
        label        = "A"
    }
}

resource "signalfx_single_value_chart" "sfx_aws_asg_group_terminating_count" {
    color_by                = "Dimension"
    max_precision           = 0
    name                    = "Total Terminating Instances"
    program_text            = "A = data('GroupTerminatingInstances', filter=filter('stat', 'mean') and filter('namespace', 'AWS/AutoScaling') and filter('AutoScalingGroupName', 'EC2ContainerService-default-439766bb-17a3-41cb-9e17-134df785fafe-EcsInstanceAsg-ZI6N93VA0FRE')).publish(label='A')"
    secondary_visualization = "None"
    show_spark_line         = false
    unit_prefix             = "Metric"

    viz_options {
        display_name = "GroupTerminatingInstances"
        label        = "A"
    }
}

resource "signalfx_time_chart" "sfx_aws_asg_group_terminating" {
    axes_include_zero  = false
    axes_precision     = 0
    color_by           = "Dimension"
    disable_sampling   = false
    minimum_resolution = 0
    name               = "Total Terminating Instances per Period"
    plot_type          = "AreaChart"
    program_text       = "A = data('GroupTerminatingInstances', filter=filter('stat', 'mean') and filter('namespace', 'AWS/AutoScaling') and filter('AutoScalingGroupName', 'EC2ContainerService-default-439766bb-17a3-41cb-9e17-134df785fafe-EcsInstanceAsg-ZI6N93VA0FRE')).publish(label='A')"
    show_data_markers  = false
    show_event_lines   = false
    stacked            = false
    time_range         = 7200
    unit_prefix        = "Metric"

    axis_left {
        label          = "# instances"
        min_value      = 0
    }

    histogram_options {
        color_theme = "red"
    }

    viz_options {
        axis         = "left"
        display_name = "GroupTerminatingInstances"
        label        = "A"
    }
}

resource "signalfx_dashboard" "sfx_aws_asg_group" {
  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.sfx_aws_asg.id
  name              = "AutoScaling - Single Group"

  variable {
          alias                  = "AutoScaling group"
          apply_if_exist         = false
          description            = "AutoScaling group"
          property               = "AutoScalingGroupName"
          replace_only           = false
          restricted_suggestions = false
          value_required         = true
          values                 = [
              "Choose group",
          ]
          values_suggested       = []
  }

	chart {
		chart_id = signalfx_single_value_chart.sfx_aws_asg_group_min_size.id
		row = 0
		column = 0
		height = 1
		width = 4
	}

	chart {
		chart_id = signalfx_single_value_chart.sfx_aws_asg_group_max_size.id
		row = 0
		column = 4
		height = 1
		width = 4
	}

	chart {
		chart_id = signalfx_single_value_chart.sfx_aws_asg_group_desired_cap.id
		row = 0
		column = 8
		height = 1
		width = 4
	}

	chart {
		chart_id = signalfx_single_value_chart.sfx_aws_asg_group_in_service_count.id
		row = 1
		column = 0
		height = 1
		width = 6
	}

	chart {
		chart_id = signalfx_time_chart.sfx_aws_asg_group_in_service.id
		row = 1
		column = 6
		height = 1
		width = 6
	}

	chart {
		chart_id = signalfx_single_value_chart.sfx_aws_asg_group_pending_count.id
		row = 2
		column = 0
		height = 1
		width = 6
	}

	chart {
		chart_id = signalfx_time_chart.sfx_aws_asg_group_pending.id
		row = 2
		column = 6
		height = 1
		width = 6
	}

	chart {
		chart_id = signalfx_single_value_chart.sfx_aws_asg_group_terminating_count.id
		row = 3
		column = 0
		height = 1
		width = 6
	}

	chart {
		chart_id = signalfx_time_chart.sfx_aws_asg_group_terminating.id
		row = 3
		column = 6
		height = 1
		width = 6
	}

}
