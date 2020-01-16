resource "signalfx_single_value_chart" "sfx_aws_elb_instances_count" {
  color_by                = "Dimension"
  description             = "that reported in last hour"
  max_precision           = 0
  name                    = "# LBs"
  program_text            = "A = data('RequestCount', filter=filter('AvailabilityZone', '*') and filter('LoadBalancerName', '*') and filter('stat', 'mean'), extrapolation='zero').sum(by=['LoadBalancerName']).count().max(over='1h').publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "# LB"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_elb_instances_latency" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Latency Over Last Minute"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('Latency', filter=filter('AvailabilityZone', '*') and filter('LoadBalancerName', '*') and filter('stat', 'mean'), extrapolation='last_value', maxExtrapolations=5).sum(by=['LoadBalancerName']).publish(label='A', enable=False)
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
    label = "ms"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "Latency - Sum by LoadBalancerName"
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

resource "signalfx_single_value_chart" "sfx_aws_elb_instances_total_reqs" {
  color_by                = "Dimension"
  max_precision           = 0
  name                    = "Total Requests/min"
  program_text            = "A = data('RequestCount', filter=filter('AvailabilityZone', '*') and filter('LoadBalancerName', '*') and filter('stat', 'sum'), extrapolation='last_value', maxExtrapolations=5).sum().scale(60).publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "RequestCount - Sum - Scale:60"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_elb_instances_latency_by_lb" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 3
  name                    = "LBs with Worst Average Latency (ms)"
  program_text            = "A = data('Latency', filter=filter('AvailabilityZone', '*') and filter('LoadBalancerName', '*') and filter('stat', 'mean'), extrapolation='last_value', maxExtrapolations=5).sum(by=['LoadBalancerName']).top(count=5).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"
}

resource "signalfx_time_chart" "sfx_aws_elb_instances_req_history" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Requests/min"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('RequestCount', filter=filter('AvailabilityZone', '*') and filter('LoadBalancerName', '*') and filter('stat', 'sum'), extrapolation='last_value', maxExtrapolations=5).scale(60).sum(by=['LoadBalancerName']).publish(label='A', enable=False)
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

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "RequestCount - Scale:60 - Sum by LoadBalancerName"
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

resource "signalfx_list_chart" "sfx_aws_elb_instances_top_lb_by_reqs" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 3
  name                    = "Top LBs by Requests/min"
  program_text            = "A = data('RequestCount', filter=filter('AvailabilityZone', '*') and filter('stat', 'sum') and filter('LoadBalancerName', '*'), extrapolation='last_value', maxExtrapolations=5).sum(by=['LoadBalancerName']).top(count=5).scale(60).publish(label='A')"
  secondary_visualization = "Sparkline"
  unit_prefix             = "Metric"
}

resource "signalfx_list_chart" "sfx_aws_elb_instances_top_fe_errs" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Top Frontend Errors/min"
  program_text            = "A = data('HTTPCode_ELB_*', filter=filter('AvailabilityZone', '*') and filter('LoadBalancerName', '*') and filter('stat', 'sum'), extrapolation='zero').sum(by=['sf_metric', 'LoadBalancerName']).scale(60).publish(label='A')"
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  unit_prefix             = "Metric"
}

resource "signalfx_list_chart" "sfx_aws_elb_instances_top_be_errs" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 3
  name                    = "Highest Backend Error %"
  program_text            = <<-EOF
        A = data('HTTPCode_Backend_*', filter=filter('stat', 'sum') and filter('AvailabilityZone', '*') and filter('LoadBalancerName', '*'), rollup='rate', extrapolation='zero').sum(by=['LoadBalancerName']).publish(label='A', enable=False)
        B = data('HTTPCode_Backend_2XX', filter=filter('stat', 'sum') and filter('AvailabilityZone', '*') and filter('LoadBalancerName', '*'), extrapolation='zero').sum(by=['LoadBalancerName']).publish(label='B', enable=False)
        C = data('HTTPCode_Backend_3XX', filter=filter('stat', 'sum') and filter('AvailabilityZone', '*') and filter('LoadBalancerName', '*'), extrapolation='zero').sum(by=['LoadBalancerName']).publish(label='C', enable=False)
        D = (1 - (B+C)/A).scale(100).publish(label='D')
    EOF
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  unit_prefix             = "Metric"

  viz_options {
    label = "D"
  }
  viz_options {
    display_name = "HTTPCode_Backend_* - Sum by LoadBalancerName"
    label        = "A"
  }
  viz_options {
    display_name = "HTTPCode_Backend_2XX - Sum by LoadBalancerName"
    label        = "B"
  }
  viz_options {
    display_name = "HTTPCode_Backend_3XX - Sum by LoadBalancerName"
    label        = "C"
  }
}

resource "signalfx_list_chart" "sfx_aws_elb_instances_top_be_errs_by_lb" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 4
  name                    = "Top Backend Connection Errors/min"
  program_text            = "A = data('BackendConnectionErrors', filter=filter('AvailabilityZone', '*') and filter('stat', 'sum') and filter('LoadBalancerName', '*'), extrapolation='zero').sum(by=['LoadBalancerName']).scale(60).publish(label='A')"
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  unit_prefix             = "Metric"
}

resource "signalfx_list_chart" "sfx_aws_elb_instances_top_unhealthy_host" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 3
  name                    = "LBs with Highest Unhealthy Host %"
  program_text            = <<-EOF
        A = data('HealthyHostCount', filter=filter('AvailabilityZone', '*') and filter('LoadBalancerName', '*') and filter('stat', 'mean'), extrapolation='last_value', maxExtrapolations=5).sum(by=['LoadBalancerName']).publish(label='A', enable=False)
        B = data('UnHealthyHostCount', filter=filter('AvailabilityZone', '*') and filter('LoadBalancerName', '*') and filter('stat', 'mean'), extrapolation='last_value', maxExtrapolations=5).sum(by=['LoadBalancerName']).publish(label='B', enable=False)
        C = (B/(A+B)).scale(100).publish(label='C')
    EOF
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  unit_prefix             = "Metric"

  viz_options {
    display_name = "HealthyHostCount - Sum by LoadBalancerName"
    label        = "A"
  }
  viz_options {
    display_name = "UnHealthyHostCount - Sum by LoadBalancerName"
    label        = "B"
  }
}

resource "signalfx_time_chart" "sfx_aws_elb_instances_historical_reqs" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "per loadbalancer"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Requests/min 7d Change %"
  plot_type          = "LineChart"
  program_text       = <<-EOF
        A = data('RequestCount', filter=filter('AvailabilityZone', '*') and filter('LoadBalancerName', '*') and filter('stat', 'sum'), extrapolation='last_value', maxExtrapolations=5).scale(60).mean(over='1h').sum(by=['LoadBalancerName']).publish(label='A', enable=False)
        B = (A).timeshift('1w').publish(label='B', enable=False)
        C = (A/B-1).scale(100).publish(label='C')
    EOF
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
    display_name = "A - Timeshift 1w"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "RequestCount - Scale:60 - Mean(1h) - Sum by LoadBalancerName"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    display_name = "change %"
    label        = "C"
  }
}

resource "signalfx_time_chart" "sfx_aws_elb_instances_historical_latency" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "per loadbalancer"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Latency 7d Change %"
  plot_type          = "LineChart"
  program_text       = <<-EOF
        A = data('Latency', filter=filter('AvailabilityZone', '*') and filter('LoadBalancerName', '*') and filter('stat', 'mean'), extrapolation='last_value', maxExtrapolations=5).sum(by=['LoadBalancerName']).mean(over='1h').publish(label='A', enable=False)
        B = (A).timeshift('1w').publish(label='B', enable=False)
        C = (A/B - 1).scale(100).publish(label='C')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label = "%"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "A - Timeshift 1w"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "Latency - Sum by LoadBalancerName - Mean(1h)"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    display_name = "change %"
    label        = "C"
  }
}

resource "signalfx_text_chart" "sfx_aws_elb_instances_notes" {
  markdown = <<-EOF
        Empty charts indicate no activity of that category

        Docs for [ELB CloudWatch metrics](http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/elb-metricscollected.html)
    EOF
  name     = "Notes"
}

resource "signalfx_dashboard" "sfx_aws_elb_instances" {

  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.sfx_aws_elb.id
  description       = "Overview of the Amazon ELB service."
  name              = "ELB Instances"

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_elb_instances_count.id
    row      = 0
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elb_instances_latency.id
    row      = 0
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_elb_instances_latency_by_lb.id
    row      = 0
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_elb_instances_total_reqs.id
    row      = 1
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elb_instances_req_history.id
    row      = 1
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_elb_instances_top_lb_by_reqs.id
    row      = 1
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_elb_instances_top_fe_errs.id
    row      = 2
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_elb_instances_top_be_errs.id
    row      = 2
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_elb_instances_top_be_errs_by_lb.id
    row      = 2
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_elb_instances_top_unhealthy_host.id
    row      = 3
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elb_instances_historical_reqs.id
    row      = 3
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elb_instances_historical_latency.id
    row      = 3
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_text_chart.sfx_aws_elb_instances_notes.id
    row      = 4
    column   = 0
    height   = 1
    width    = 4
  }

}
