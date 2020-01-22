resource "signalfx_time_chart" "sfx_aws_route53_healthcheck_0" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "HealthCheckStatus"
  plot_type          = "AreaChart"
  program_text       = "A = data('HealthCheckStatus', filter=filter('namespace', 'AWS/Route53') and filter('HealthCheckId', '48f50fa0-a734-42c6-b7ce-b4dc7d7fd5b9') and filter('stat', 'lower')).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "HealthCheckStatus"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_route53_healthcheck_1" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "HealthCheckPercentageHealthy"
  plot_type          = "AreaChart"
  program_text       = "A = data('HealthCheckPercentageHealthy', filter=filter('namespace', 'AWS/Route53') and filter('HealthCheckId', '48f50fa0-a734-42c6-b7ce-b4dc7d7fd5b9') and filter('stat', 'mean')).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "% healthy"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "HealthCheckPercentageHealthy"
    label        = "A"
  }
}

resource "signalfx_dashboard" "sfx_aws_route53_healthcheck" {

  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.sfx_aws_route53.id
  name              = "Route53 HealthCheck"

  variable {
    alias                  = "health check"
    apply_if_exist         = false
    description            = "Route53 Health Check"
    property               = "HealthCheckId"
    replace_only           = false
    restricted_suggestions = false
    value_required         = true
    values = [
      "Choose check",
    ]
    values_suggested = []
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_route53_healthcheck_0.id
    row      = 0
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_route53_healthcheck_1.id
    row      = 0
    column   = 6
    height   = 1
    width    = 6
  }

}
