resource "signalfx_single_value_chart" "sfx_aws_elb_instance_total_reqs" {
  color_by                = "Dimension"
  max_precision           = 4
  name                    = "Total Routed Requests/min"
  program_text            = "A = data('RequestCount', filter=filter('stat', 'sum') and filter('AvailabilityZone', '*') and filter('LoadBalancerName', '*'), extrapolation='last_value', maxExtrapolations=5).sum().scale(60).publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "RequestCount - Sum - Scale:60"
    label        = "A"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_elb_instance_healthy_count" {
  color_by                = "Dimension"
  max_precision           = 1
  name                    = "Healthy Hosts"
  program_text            = "A = data('HealthyHostCount', filter=filter('stat', 'mean') and (not filter('AvailabilityZone', '*')), extrapolation='last_value', maxExtrapolations=5).publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "Total Healthy"
    label        = "A"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_elb_instance_latency" {
  color_by                = "Dimension"
  max_precision           = 2
  name                    = "Avg latency (ms)"
  program_text            = <<-EOF
        A = data('Latency', filter=filter('stat', 'mean') and filter('AvailabilityZone', '*') and filter('LoadBalancerName', '*'), extrapolation='last_value', maxExtrapolations=5).mean().publish(label='A', enable=False)
        B = (A*1000).publish(label='B')
    EOF
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "A*1000"
    label        = "B"
  }
  viz_options {
    display_name = "Latency - Mean"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_elb_instance_top_http_codes" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "HTTP Result Codes/min"
  program_text            = "A = data('HTTPCode_*', filter=filter('stat', 'sum') and filter('AvailabilityZone', '*') and filter('LoadBalancerName', 'lb-app-bb-LoadBala-NW8XPG9619V8'), extrapolation='zero').sum(by=['sf_metric']).scale(60).publish(label='A')"
  secondary_visualization = "Sparkline"
  sort_by                 = "-sf_originatingMetric"
  unit_prefix             = "Metric"
}

resource "signalfx_single_value_chart" "sfx_aws_elb_instance_unhealthy" {
  color_by                = "Dimension"
  max_precision           = 1
  name                    = "Unhealthy Hosts"
  program_text            = "B = data('UnHealthyHostCount', filter=filter('stat', 'mean') and (not filter('AvailabilityZone', '*')), extrapolation='last_value', maxExtrapolations=5).publish(label='B')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "Total Unhealthy"
    label        = "B"
  }
}

resource "signalfx_list_chart" "sfx_aws_elb_instance_surge_spill" {
  color_by                = "Dimension"
  description             = "over last minute (no data means zero)"
  disable_sampling        = false
  max_precision           = 2
  name                    = "Spillover  & Max SurgeQueue"
  program_text            = <<-EOF
        A = data('SurgeQueueLength', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'upper'), extrapolation='zero').max().publish(label='A')
        B = data('SpilloverCount', filter=filter('stat', 'sum') and filter('namespace', 'AWS/ELB') and filter('AvailabilityZone', '*')).sum().scale(60).publish(label='B')
    EOF
  secondary_visualization = "Sparkline"
  sort_by                 = "+sf_metric"
  unit_prefix             = "Metric"

  viz_options {
    color        = "blue"
    display_name = "SurgeQueueLength"
    label        = "A"
  }
  viz_options {
    color        = "brown"
    display_name = "SpilloverCount"
    label        = "B"
  }
}

resource "signalfx_time_chart" "sfx_aws_elb_instance_req_history" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Requests/min by AZ"
  plot_type          = "LineChart"
  program_text       = "A = data('RequestCount', filter=filter('stat', 'sum') and filter('AvailabilityZone', '*') and filter('LoadBalancerName', '*'), extrapolation='last_value', maxExtrapolations=5).sum(by=['AvailabilityZone']).scale(60).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "# requests / min"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "requests/min"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_elb_instance_err_history" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Errors/min by AZ"
  plot_type          = "LineChart"
  program_text       = "A = data('HTTPCode_*', filter=filter('stat', 'sum') and filter('AvailabilityZone', '*') and filter('LoadBalancerName', '*') and (not filter('sf_metric', 'HTTPCode_Backend_2XX')), rollup='rate', extrapolation='last_value', maxExtrapolations=5).sum(by=['AvailabilityZone']).scale(60).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "# errors/min"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "# errors/min"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_elb_instance_latency_history" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Avg Response Latency (ms) by AZ"
  plot_type          = "LineChart"
  program_text       = <<-EOF
        A = data('Latency', filter=filter('stat', 'mean') and filter('AvailabilityZone', '*') and filter('LoadBalancerName', '*'), extrapolation='last_value', maxExtrapolations=5).mean(by=['AvailabilityZone']).publish(label='A', enable=False)
        B = (A*1000).publish(label='B')
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
    display_name = "A*1000"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "Latency - Mean by AvailabilityZone"
    label        = "A"
  }
}

resource "signalfx_text_chart" "sfx_aws_elb_instance_note" {
  markdown = <<-EOF
        Empty charts indicate no activity of that category

        Docs for [ELB CloudWatch metrics](http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/elb-metricscollected.html)
    EOF
  name     = "Notes"
}

resource "signalfx_dashboard" "sfx_aws_elb_instance" {

  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.sfx_aws_elb.id
  name              = "ELB Instance"

  variable {
    alias                  = "load balancer"
    apply_if_exist         = false
    description            = "Load Balancer"
    property               = "LoadBalancerName"
    replace_only           = false
    restricted_suggestions = false
    value_required         = true
    values = [
      "Choose Load Balancer",
    ]
    values_suggested = []
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_elb_instance_total_reqs.id
    row      = 0
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_elb_instance_healthy_count.id
    row      = 0
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_elb_instance_latency.id
    row      = 0
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_elb_instance_top_http_codes.id
    row      = 1
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_elb_instance_unhealthy.id
    row      = 1
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_elb_instance_surge_spill.id
    row      = 1
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elb_instance_req_history.id
    row      = 2
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elb_instance_err_history.id
    row      = 2
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elb_instance_latency_history.id
    row      = 2
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_text_chart.sfx_aws_elb_instance_note.id
    row      = 3
    column   = 0
    height   = 1
    width    = 4
  }

}
