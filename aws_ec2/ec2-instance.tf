resource "signalfx_single_value_chart" "sfx_aws_ec2_instance_cpu" {
  name         = "CPU %"
  program_text = "A = data('CPUUtilization', filter=filter('namespace', 'AWS/EC2') and filter('stat', 'mean') and filter('InstanceId', 'i-e8b1df4b'), extrapolation='last_value', maxExtrapolations=5).publish(label='A')"

  max_precision = 2
  color_by      = "Dimension"
}

resource "signalfx_time_chart" "sfx_aws_ec2_cpu_trend" {
  name         = "CPU % Trend"
  program_text = "A = data('CPUUtilization', filter=filter('namespace', 'AWS/EC2') and filter('stat', 'mean') and filter('InstanceId', 'i-e8b1df4b'), extrapolation='last_value', maxExtrapolations=5).publish(label='A')"

  plot_type  = "AreaChart"
  time_range = 7200

  axis_left {
    label     = "cpu %"
    max_value = 110
    min_value = 0
  }

  viz_options {
    label        = "A"
    display_name = "cpu %"
  }
}

resource "signalfx_list_chart" "sfx_aws_ec2_disk_io_list" {
  name         = "Disk I/O / Min"
  program_text = "A = data('Disk*', filter=filter('namespace', 'AWS/EC2') and filter('InstanceId', 'i-e8b1df4b') and filter('stat', 'sum'), extrapolation='last_value', maxExtrapolations=5).mean(by=['sf_metric']).scale(60).publish(label='A')"

  time_range    = 900
  max_precision = 4

  sort_by = "+sf_originatingMetric"
}

resource "signalfx_time_chart" "sfx_aws_ec2_disk_io_bytes" {
  name         = "Disk I/O Bytes/Min"
  program_text = <<-EOF
A = data('DiskWriteBytes', filter=filter('namespace', 'AWS/EC2') and filter('InstanceId', 'i-e8b1df4b') and filter('stat', 'sum'), extrapolation='last_value', maxExtrapolations=5).sum().scale(60).publish(label='A')
B = data('DiskReadBytes', filter=filter('namespace', 'AWS/EC2') and filter('InstanceId', 'i-e8b1df4b') and filter('stat', 'sum'), extrapolation='last_value', maxExtrapolations=5).sum().scale(60).publish(label='B')
  EOF

  time_range = 7200

  plot_type   = "ColumnChart"
  unit_prefix = "Binary"

  viz_options {
    label        = "A"
    axis         = "left"
    color        = "blue"
    display_name = "bytes written/interval"
  }

  viz_options {
    label        = "B"
    axis         = "right"
    color        = "brown"
    display_name = "bytes read/interval"
  }

  axis_left {
    label     = "bytes written - BLUE"
    min_value = 0
  }

  axis_right {
    label     = "bytes read - RED"
    min_value = 0
  }
}

resource "signalfx_time_chart" "sfx_aws_ec2_disk_iops" {
  name         = "Disk IOPs/Min"
  program_text = <<-EOF
A = data('DiskWriteOps', filter=filter('namespace', 'AWS/EC2') and filter('InstanceId', 'i-e8b1df4b') and filter('stat', 'sum'), extrapolation='last_value', maxExtrapolations=5).sum().scale(60).publish(label='A')
B = data('DiskReadOps', filter=filter('namespace', 'AWS/EC2') and filter('InstanceId', 'i-e8b1df4b') and filter('stat', 'sum'), extrapolation='last_value', maxExtrapolations=5).sum().scale(60).publish(label='B')
  EOF

  time_range = 7200

  plot_type = "ColumnChart"

  viz_options {
    label        = "A"
    axis         = "left"
    color        = "blue"
    display_name = "write ops/interval"
  }

  viz_options {
    label        = "B"
    axis         = "right"
    color        = "brown"
    display_name = "read ops/interval"
  }

  axis_left {
    label     = "write ops - BLUE"
    min_value = 0
  }

  axis_right {
    label     = "read ops - RED"
    min_value = 0
  }
}

resource "signalfx_list_chart" "sfx_aws_ec2_network_io_list" {
  name         = "Network I/O Bytes/Min"
  program_text = <<-EOF
A = data('NetworkIn', filter=filter('namespace', 'AWS/EC2') and filter('InstanceId', 'i-e8b1df4b') and filter('stat', 'sum'), extrapolation='last_value', maxExtrapolations=5).mean().scale(60).publish(label='A')
B = data('NetworkOut', filter=filter('namespace', 'AWS/EC2') and filter('InstanceId', 'i-e8b1df4b') and filter('stat', 'sum'), extrapolation='last_value', maxExtrapolations=5).mean().scale(60).publish(label='B')
  EOF

  time_range    = 900
  max_precision = 3
  unit_prefix   = "Binary"

  sort_by = "+sf_originatingMetric"

  viz_options {
    label        = "A"
    display_name = "bytes in"
  }

  viz_options {
    label        = "B"
    display_name = "bytes out"
  }
}

resource "signalfx_time_chart" "sfx_aws_ec2_network_io_bytes" {
  name         = "Network I/O Bytes/Min"
  program_text = <<-EOF
A = data('NetworkIn', filter=filter('namespace', 'AWS/EC2') and filter('InstanceId', 'i-e8b1df4b') and filter('stat', 'sum'), extrapolation='last_value', maxExtrapolations=5).sum().scale(60).publish(label='A')
B = data('NetworkOut', filter=filter('namespace', 'AWS/EC2') and filter('InstanceId', 'i-e8b1df4b') and filter('stat', 'sum'), extrapolation='last_value', maxExtrapolations=5).sum().scale(60).publish(label='B')
  EOF

  time_range = 7200

  plot_type   = "ColumnChart"
  unit_prefix = "Binary"

  viz_options {
    label        = "A"
    axis         = "right"
    color        = "blue"
    display_name = "bytes in/interval"
  }

  viz_options {
    label        = "B"
    axis         = "left"
    color        = "brown"
    display_name = "bytes out/interval"
  }

  axis_left {
    label     = "bytes out - BLUE"
    min_value = 0
  }

  axis_right {
    label     = "bytes in - RED"
    min_value = 0
  }
}

resource "signalfx_time_chart" "sfx_aws_ec2_disk_bytes_per_op" {
  name         = "Disk I/O Bytes/Operation"
  program_text = <<-EOF
A = data('DiskWriteBytes', filter=filter('stat', 'mean') and filter('namespace', 'AWS/EC2') and filter('InstanceId', 'i-e8b1df4b')).sum().publish(label='A', enable=False)
B = data('DiskReadBytes', filter=filter('stat', 'mean') and filter('namespace', 'AWS/EC2') and filter('InstanceId', 'i-e8b1df4b')).sum().publish(label='B', enable=False)
C = data('DiskWriteOps', filter=filter('stat', 'mean') and filter('namespace', 'AWS/EC2') and filter('InstanceId', 'i-e8b1df4b')).sum().publish(label='C', enable=False)
D = data('DiskReadOps', filter=filter('stat', 'mean') and filter('namespace', 'AWS/EC2') and filter('InstanceId', 'i-e8b1df4b')).sum().publish(label='D', enable=False)
E = (A/C).publish(label='E')
F = (B/D).publish(label='F')
  EOF

  time_range = 7200

  plot_type   = "ColumnChart"
  unit_prefix = "Binary"

  viz_options {
    label        = "E"
    axis         = "left"
    color        = "blue"
    display_name = "byte/write"
  }

  viz_options {
    label        = "F"
    axis         = "right"
    color        = "brown"
    display_name = "byte/read"
  }

  axis_left {
    label     = "bytes/write - BLUE"
    min_value = 0
  }

  axis_right {
    label     = "bytes/read - RED"
    min_value = 0
  }
}

resource "signalfx_dashboard" "sfx_aws_ec2_instance" {
  name            = "EC2 Instance"
  dashboard_group = signalfx_dashboard_group.sfx_aws_ec2.id

  variable {
    alias                  = "instance"
    apply_if_exist         = false
    description            = "EC2 instance"
    property               = "InstanceId"
    replace_only           = false
    restricted_suggestions = false
    value_required         = true
    values = [
      "Choose instance",
    ]
    values_suggested = []
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_ec2_instance_cpu.id
    width    = 6
    height   = 1
    row      = 1
    column   = 0
  }
  chart {
    chart_id = signalfx_time_chart.sfx_aws_ec2_cpu_trend.id
    width    = 6
    height   = 1
    row      = 1
    column   = 6
  }
  chart {
    chart_id = signalfx_list_chart.sfx_aws_ec2_disk_io_list.id
    width    = 4
    height   = 1
    row      = 2
    column   = 0
  }
  chart {
    chart_id = signalfx_time_chart.sfx_aws_ec2_disk_io_bytes.id
    width    = 4
    height   = 1
    row      = 2
    column   = 4
  }
  chart {
    chart_id = signalfx_time_chart.sfx_aws_ec2_disk_iops.id
    width    = 4
    height   = 1
    row      = 2
    column   = 8
  }
  chart {
    chart_id = signalfx_list_chart.sfx_aws_ec2_network_io_list.id
    width    = 4
    height   = 1
    row      = 3
    column   = 0
  }
  chart {
    chart_id = signalfx_time_chart.sfx_aws_ec2_network_io_bytes.id
    width    = 4
    height   = 1
    row      = 3
    column   = 4
  }
  chart {
    chart_id = signalfx_time_chart.sfx_aws_ec2_disk_bytes_per_op.id
    width    = 4
    height   = 1
    row      = 3
    column   = 8
  }
}
