resource "signalfx_time_chart" "sfx_aws_cloudfront_distribution_reqs" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Requests/Interval"
  plot_type          = "AreaChart"
  program_text       = "A = data('Requests', filter=filter('namespace', 'AWS/CloudFront') and filter('stat', 'sum') and filter('DistributionId', 'EJH671JAOI5SN')).scale(60).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "# requests"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "Requests - Scale:60"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_cloudfront_distribution_err_rate" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Total Error Rate %"
  plot_type          = "AreaChart"
  program_text       = "A = data('TotalErrorRate', filter=filter('namespace', 'AWS/CloudFront') and filter('DistributionId', 'EJH671JAOI5SN') and filter('stat', 'mean')).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "%"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "TotalErrorRate"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_cloudfront_distribution_bytes_down" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Bytes Downloaded/Interval"
  plot_type          = "AreaChart"
  program_text       = "A = data('BytesDownloaded', filter=filter('namespace', 'AWS/CloudFront') and filter('stat', 'sum') and filter('DistributionId', 'EJH671JAOI5SN')).scale(60).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Binary"

  axis_left {
    label     = "bytes"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "BytesDownloaded - Scale:60"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_cloudfront_distribution_bytes_up" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Bytes Uploaded/Interval"
  plot_type          = "AreaChart"
  program_text       = "A = data('BytesUploaded', filter=filter('namespace', 'AWS/CloudFront') and filter('stat', 'sum') and filter('DistributionId', 'EJH671JAOI5SN')).scale(60).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Binary"

  axis_left {
    label     = "bytes"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "BytesUploaded - Scale:60"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_cloudfront_distribution_4xx_rate" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "4xx Error Rate %"
  plot_type          = "AreaChart"
  program_text       = "A = data('4xxErrorRate', filter=filter('namespace', 'AWS/CloudFront') and filter('DistributionId', 'EJH671JAOI5SN') and filter('stat', 'mean')).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "# errors"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "4xxErrorRate"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_cloudfront_distribution_5xx_rate" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "5xx Error Rate %"
  plot_type          = "AreaChart"
  program_text       = "A = data('5xxErrorRate', filter=filter('namespace', 'AWS/CloudFront') and filter('DistributionId', 'EJH671JAOI5SN') and filter('stat', 'mean')).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "%"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "5xxErrorRate"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_cloudfront_distribution_req_history" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Requests/Interval 24h Change %"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('Requests', filter=filter('namespace', 'AWS/CloudFront') and filter('stat', 'sum') and filter('DistributionId', 'EJH671JAOI5SN')).scale(60).mean(over='1h').publish(label='A', enable=False)
        B = (A).timeshift('1d').publish(label='B', enable=False)
        C = ((A-B)/B*100).publish(label='C')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label = "change %"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "24h change %"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    display_name = "A - Timeshift 1d"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "Requests - Scale:60 - Mean(1h)"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_cloudfront_distribution_bytes_down_history" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Bytes Downloaded/Interval 24h Change %"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('BytesDownloaded', filter=filter('namespace', 'AWS/CloudFront') and filter('stat', 'sum') and filter('DistributionId', 'EJH671JAOI5SN')).scale(60).mean(over='1h').publish(label='A', enable=False)
        B = (A).timeshift('1d').publish(label='B', enable=False)
        C = ((A-B)/B*100).publish(label='C')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label = "change %"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "24h change %"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    display_name = "A - Timeshift 1d"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "BytesDownloaded - Scale:60 - Mean(1h)"
    label        = "A"
  }
}

resource "signalfx_dashboard" "sfx_aws_cloudfront_distribution" {
  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.sfx_aws_cloudfront.id
  name              = "CloudFront Distribution"

  variable {
    alias                  = "distribution"
    apply_if_exist         = false
    description            = "CloudFront distribution"
    property               = "DistributionId"
    replace_only           = false
    restricted_suggestions = false
    value_required         = true
    values = [
      "Choose distribution",
    ]
    values_suggested = []
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_cloudfront_distribution_reqs.id
    row      = 0
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_cloudfront_distribution_err_rate.id
    row      = 0
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_cloudfront_distribution_bytes_down.id
    row      = 1
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_cloudfront_distribution_bytes_up.id
    row      = 1
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_cloudfront_distribution_4xx_rate.id
    row      = 2
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_cloudfront_distribution_5xx_rate.id
    row      = 2
    column   = 6
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_cloudfront_distribution_req_history.id
    row      = 3
    column   = 0
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_cloudfront_distribution_bytes_down_history.id
    row      = 3
    column   = 6
    height   = 1
    width    = 6
  }

}
