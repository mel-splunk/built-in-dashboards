resource "signalfx_single_value_chart" "sfx_aws_ec2_instances_active_hosts" {
  color_by                = "Dimension"
  description             = "that reported in last hour"
  is_timestamp_hidden     = false
  max_precision           = 5
  name                    = "Active Hosts"
  program_text            = <<-EOF
  A = data('CPUUtilization', filter=filter('namespace', 'AWS/EC2') and filter('stat', 'upper') and filter('InstanceId', '*'), extrapolation='last_value', maxExtrapolations=5).max(over='1h').count().publish(label='A')
    EOF
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "# hosts"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_ec2_instances_active_by_type" {
  color_by                = "Dimension"
  description             = "that reported in last hour"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Active Hosts Per Instance Type"
  program_text            = <<-EOF
  A = data('CPUUtilization', filter=filter('stat', 'mean') and filter('namespace', 'AWS/EC2') and filter('InstanceId', '*'), extrapolation='last_value', maxExtrapolations=5).max(over='1h').count(by=['aws_instance_type']).publish(label='A')
    EOF
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  unit_prefix             = "Metric"
}

resource "signalfx_list_chart" "sfx_aws_ec2_instances_active_by_az" {
  color_by                = "Dimension"
  description             = "that reported in last hour"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Active Hosts by AZ"
  program_text            = <<-EOF
  A = data('CPUUtilization', filter=filter('stat', 'mean') and filter('namespace', 'AWS/EC2') and filter('InstanceId', '*'), extrapolation='last_value', maxExtrapolations=5).max(over='1h').count(by=['aws_availability_zone']).publish(label='A')
    EOF
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  unit_prefix             = "Metric"
}

resource "signalfx_time_chart" "sfx_aws_ec2_instances_cpu_pct" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "CPU %"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('CPUUtilization', filter=filter('stat', 'mean') and filter('namespace', 'AWS/EC2') and filter('InstanceId', '*'), extrapolation='last_value', maxExtrapolations=5).publish(label='A', enable=False)
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
    label     = "cpu %"
    max_value = 110
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "CPUUtilization"
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

resource "signalfx_list_chart" "sfx_aws_ec2_instances_top_cpu_pct" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 3
  name                    = "Top Instances by CPU %"
  program_text            = <<-EOF
  A = data('CPUUtilization', filter=filter('stat', 'mean') and filter('namespace', 'AWS/EC2') and filter('InstanceId', '*'), extrapolation='last_value', maxExtrapolations=5).mean(by=['InstanceId']).top(count=5).publish(label='A')
    EOF
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  unit_prefix             = "Metric"
}

resource "signalfx_list_chart" "sfx_aws_ec2_instances_top_image_cpu_pct" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 3
  name                    = "Top Images by Mean CPU %"
  program_text            = <<-EOF
  A = data('CPUUtilization', filter=filter('stat', 'mean') and filter('namespace', 'AWS/EC2') and filter('InstanceId', '*'), extrapolation='last_value', maxExtrapolations=5).mean(by=['aws_image_id']).top(count=5).publish(label='A')
    EOF
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  unit_prefix             = "Metric"
}

resource "signalfx_time_chart" "sfx_aws_ec2_instances_disk_ops" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Disk Ops/Min"
  plot_type          = "ColumnChart"
  program_text       = <<-EOF
        A = data('DiskWriteOps', filter=filter('namespace', 'AWS/EC2') and filter('InstanceId', '*') and filter('stat', 'sum'), rollup='rate', extrapolation='last_value', maxExtrapolations=5).sum().scale(60).publish(label='A')
        B = data('DiskReadOps', filter=filter('namespace', 'AWS/EC2') and filter('InstanceId', '*') and filter('stat', 'sum'), rollup='rate', extrapolation='last_value', maxExtrapolations=5).sum().scale(60).publish(label='B')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "writes - BLUE"
    min_value = 0
  }

  axis_right {
    label     = "reads - RED"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    color        = "blue"
    display_name = "write ops/min"
    label        = "A"
  }
  viz_options {
    axis         = "right"
    color        = "brown"
    display_name = "read ops/min"
    label        = "B"
  }
}

resource "signalfx_time_chart" "sfx_aws_ec2_instances_disk_bytes" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Disk I/O Bytes/Min"
  plot_type          = "ColumnChart"
  program_text       = <<-EOF
        A = data('DiskWriteBytes', filter=filter('namespace', 'AWS/EC2') and filter('InstanceId', '*') and filter('stat', 'sum'), rollup='rate', extrapolation='last_value', maxExtrapolations=5).sum().scale(60).publish(label='A')
        B = data('DiskReadBytes', filter=filter('namespace', 'AWS/EC2') and filter('InstanceId', '*') and filter('stat', 'sum'), rollup='rate', extrapolation='last_value', maxExtrapolations=5).sum().scale(60).publish(label='B')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Binary"

  axis_left {
    label     = "bytes written - BLUE"
    min_value = 0
  }

  axis_right {
    label     = "bytes read - RED"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    color        = "blue"
    display_name = "bytes written/min"
    label        = "A"
  }
  viz_options {
    axis         = "right"
    color        = "brown"
    display_name = "bytes read/min"
    label        = "B"
  }
}

resource "signalfx_list_chart" "sfx_aws_ec2_instances_disk_metrics" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "Disk Metrics 24h Growth %"
  program_text            = <<-EOF
        A = data('Disk*', filter=filter('namespace', 'AWS/EC2') and filter('InstanceId', '*') and filter('stat', 'sum'), rollup='rate', extrapolation='last_value', maxExtrapolations=5).sum(by=['sf_metric']).scale(60).mean(over='1h').publish(label='A', enable=False)
        B = (A).timeshift('1d').publish(label='B', enable=False)
        C = (A/B - 1).scale(100).publish(label='C')
    EOF
  secondary_visualization = "Sparkline"
  sort_by                 = "+sf_originatingMetric"
  unit_prefix             = "Metric"

  viz_options {
    display_name = "A - Timeshift 1d"
    label        = "B"
  }
}

resource "signalfx_time_chart" "sfx_aws_ec2_instances_network_bytes" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Network Bytes In"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('NetworkIn', filter=filter('namespace', 'AWS/EC2') and filter('InstanceId', '*') and filter('stat', 'sum'), extrapolation='last_value', maxExtrapolations=5).scale(60).publish(label='A', enable=False)
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
  unit_prefix        = "Binary"

  axis_left {
    label     = "bytes/interval"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "NetworkIn - Scale:60"
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

resource "signalfx_time_chart" "sfx_aws_ec2_instances_network_bytes_compare" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Network Bytes In vs. 24h Change %"
  plot_type          = "ColumnChart"
  program_text       = <<-EOF
        A = data('NetworkIn', filter=filter('namespace', 'AWS/EC2') and filter('InstanceId', '*') and filter('stat', 'sum'), extrapolation='last_value', maxExtrapolations=5).sum().scale(60).publish(label='A')
        B = (A).mean(over='1h').publish(label='B', enable=False)
        C = (B).timeshift('1d').publish(label='C', enable=False)
        D = (B/C - 1).scale(100).publish(label='D')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Binary"

  axis_left {
    label = "bytes/min - BLUE"
  }

  axis_right {
    label = "% change - RED"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "A - Mean(1h)"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "NetworkIn"
    label        = "A"
  }
  viz_options {
    axis      = "right"
    color     = "brown"
    label     = "C"
    plot_type = "LineChart"
  }
  viz_options {
    axis         = "right"
    color        = "brown"
    display_name = "24h growth %"
    label        = "D"
    plot_type    = "LineChart"
  }
}

resource "signalfx_list_chart" "sfx_aws_ec2_instances_top_network_bytes" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 4
  name                    = "Top Network Bytes In/Min"
  program_text            = <<-EOF
  A = data('NetworkIn', filter=filter('namespace', 'AWS/EC2') and filter('InstanceId', '*') and filter('stat', 'sum'), extrapolation='last_value', maxExtrapolations=5).scale(60).mean(by=['InstanceId']).top(count=5).publish(label='A')
    EOF
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  unit_prefix             = "Binary"
}

resource "signalfx_time_chart" "sfx_aws_ec2_instances_network_bytes_out" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Network Bytes Out"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('NetworkOut', filter=filter('namespace', 'AWS/EC2') and filter('InstanceId', '*') and filter('stat', 'sum'), extrapolation='last_value', maxExtrapolations=5).scale(60).publish(label='A', enable=False)
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
  unit_prefix        = "Binary"

  axis_left {
    label     = "bytes/interval"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "NetworkOut - Scale:60"
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

resource "signalfx_list_chart" "sfx_aws_ec2_instances_top_network_bytes_out" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 4
  name                    = "Top Network Bytes Out/Min"
  program_text            = <<-EOF
  A = data('NetworkOut', filter=filter('namespace', 'AWS/EC2') and filter('InstanceId', '*') and filter('stat', 'sum'), extrapolation='last_value', maxExtrapolations=5).scale(60).mean(by=['InstanceId']).top(count=5).publish(label='A')
    EOF
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  unit_prefix             = "Binary"
}

resource "signalfx_time_chart" "sfx_aws_ec2_instances_network_bytes_out_compare" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Network Bytes Out vs. 24h Change %"
  plot_type          = "ColumnChart"
  program_text       = <<-EOF
        A = data('NetworkOut', filter=filter('namespace', 'AWS/EC2') and filter('InstanceId', '*') and filter('stat', 'sum'), extrapolation='last_value', maxExtrapolations=5).scale(60).sum().mean(over='1h').publish(label='A')
        B = (A).timeshift('1d').publish(label='B', enable=False)
        C = (A/B - 1).scale(100).publish(label='C')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Binary"

  axis_left {
    label = "bytes/min - BLUE"
  }

  axis_right {
    label = "% change - RED"
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "A - Timeshift 1d"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "NetworkIn"
    label        = "A"
  }
  viz_options {
    axis         = "right"
    color        = "brown"
    display_name = "24h growth %"
    label        = "C"
    plot_type    = "LineChart"
  }
}

resource "signalfx_dashboard" "sfx_aws_ec2_instances" {
  name = "EC2 Instances"

  dashboard_group = signalfx_dashboard_group.sfx_aws.id

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_ec2_instances_active_hosts.id
    row      = 0
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_ec2_instances_active_by_type.id
    row      = 0
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_ec2_instances_active_by_az.id
    row      = 0
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_ec2_instances_cpu_pct.id
    row      = 1
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_ec2_instances_top_cpu_pct.id
    row      = 1
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_ec2_instances_top_image_cpu_pct.id
    row      = 1
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_ec2_instances_disk_ops.id
    row      = 2
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_ec2_instances_disk_bytes.id
    row      = 2
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_ec2_instances_disk_metrics.id
    row      = 2
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_ec2_instances_network_bytes.id
    row      = 3
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_ec2_instances_top_network_bytes.id
    row      = 3
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_ec2_instances_network_bytes_compare.id
    row      = 3
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_ec2_instances_network_bytes_out.id
    row      = 4
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_ec2_instances_top_network_bytes_out.id
    row      = 4
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_ec2_instances_network_bytes_out_compare.id
    row      = 4
    column   = 8
    height   = 1
    width    = 4
  }
}
