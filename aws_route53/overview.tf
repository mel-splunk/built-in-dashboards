resource "signalfx_single_value_chart" "sfx_aws_route53_overview_0" {
  color_by                = "Dimension"
  is_timestamp_hidden     = false
  max_precision           = 0
  name                    = "# HealthChecks"
  program_text            = "A = data('HealthCheckStatus', filter=filter('namespace', 'AWS/Route53') and filter('stat', 'lower'), extrapolation='last_value', maxExtrapolations=5).count().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "HealthCheckStatus - Count"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_route53_overview_1" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "# HealthChecks by Status"
  program_text            = <<-EOF
        A = data('HealthCheckStatus', filter=filter('namespace', 'AWS/Route53') and filter('stat', 'lower'), extrapolation='last_value', maxExtrapolations=5).above(1, inclusive=True).count().publish(label='A')
        B = data('HealthCheckStatus', filter=filter('namespace', 'AWS/Route53') and filter('stat', 'lower'), extrapolation='last_value', maxExtrapolations=5).count().publish(label='B', enable=False)
        C = (B-A).publish(label='C')
    EOF
  secondary_visualization = "Sparkline"
  sort_by                 = "+sf_metric"
  unit_prefix             = "Metric"

  viz_options {
    display_name = "Healthy"
    label        = "A"
  }
  viz_options {
    display_name = "Healthy"
    label        = "B"
  }
  viz_options {
    display_name = "Unhealthy"
    label        = "C"
  }
}

resource "signalfx_time_chart" "sfx_aws_route53_overview_2" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "HealthCheckPercentageHealthy"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('HealthCheckPercentageHealthy', filter=filter('namespace', 'AWS/Route53') and filter('stat', 'mean')).mean(by=['HealthCheckId']).publish(label='A', enable=False)
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
    label     = "% healthy"
    max_value = 110
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "HealthCheckPercentageHealthy - Mean by HealthCheckId"
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

resource "signalfx_list_chart" "sfx_aws_route53_overview_3" {
  color_by                = "Dimension"
  description             = "healthchecks that are least healthy"
  disable_sampling        = false
  max_precision           = 0
  name                    = "HealthCheckPercentageHealthy"
  program_text            = "A = data('HealthCheckPercentageHealthy', filter=filter('namespace', 'AWS/Route53') and filter('stat', 'mean'), extrapolation='last_value', maxExtrapolations=5).mean(by=['HealthCheckId']).bottom(count=10).publish(label='A')"
  secondary_visualization = "Sparkline"
  sort_by                 = "+value"
  unit_prefix             = "Metric"
}

resource "signalfx_dashboard" "sfx_aws_route53_overview" {

  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.sfx_aws_route53.id
  name              = "Route53"

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_route53_overview_0.id
    row      = 0
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_route53_overview_1.id
    row      = 0
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_route53_overview_2.id
    row      = 1
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_route53_overview_3.id
    row      = 1
    column   = 6
    height   = 1
    width    = 6
  }

}
