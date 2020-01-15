resource "signalfx_single_value_chart" "sfx_aws_elasticache_clusters" {
  color_by                = "Dimension"
  max_precision           = 0
  name                    = "# Clusters"
  program_text            = "A = data('CPUUtilization', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('CacheClusterId', '*'), extrapolation='last_value', maxExtrapolations=5).mean(by=['aws_region', 'aws_cache_cluster_name']).count().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "CPUUtilization - Mean by aws_region,aws_cache_cluster_name - Count"
    label        = "A"
  }
}

resource "signalfx_single_value_chart" "sfx_aws_elasticache_nodes" {
  color_by                = "Dimension"
  max_precision           = 0
  name                    = "# Nodes"
  program_text            = "A = data('CPUUtilization', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('CacheNodeId', '*') and filter('stat', 'mean'), extrapolation='last_value', maxExtrapolations=5).mean(by=['aws_region', 'CacheClusterId', 'CacheNodeId']).count().publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "CPUUtilization - Mean by aws_region,CacheClusterId,CacheNodeId - Count"
    label        = "A"
  }
}

resource "signalfx_list_chart" "sfx_aws_elasticache_nodes_per_cluster" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 0
  name                    = "# Nodes per Cluster"
  program_text            = "A = data('CPUUtilization', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('aws_cache_cluster_name', '*') and filter('CacheClusterId', '*') and filter('CacheNodeId', '*'), extrapolation='last_value', maxExtrapolations=5).count(by=['aws_region', 'aws_cache_cluster_name']).publish(label='A')"
  secondary_visualization = "Sparkline"
  sort_by                 = "-value"
  unit_prefix             = "Metric"
}

resource "signalfx_time_chart" "sfx_aws_elasticache_hits_misses" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Hits + Misses by Cluster"
  plot_type          = "LineChart"
  program_text       = <<-EOF
        A = data('*Hits', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('stat', 'sum') and (not filter('CacheNodeId', '*'))).sum(by=['aws_region', 'aws_cache_cluster_name']).scale(60).publish(label='A', enable=False)
        B = data('*Misses', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('stat', 'sum') and (not filter('CacheNodeId', '*'))).sum(by=['aws_region', 'aws_cache_cluster_name']).scale(60).publish(label='B', enable=False)
        C = (A+B).publish(label='C')
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "hits + misses"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "*Hits - Sum by aws_region,aws_cache_cluster_name - Scale:60"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    display_name = "*Misses - Sum by aws_region,aws_cache_cluster_name - Scale:60"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "hits + misses"
    label        = "C"
  }
}

resource "signalfx_time_chart" "sfx_aws_elasticache_overall_hit_rate" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "across all categories of hits and misses"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Overall Hit Rate by Cluster"
  plot_type          = "LineChart"
  program_text       = <<-EOF
        A = data('*Hits', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('stat', 'sum') and (not filter('CacheNodeId', '*'))).sum(by=['aws_region', 'aws_cache_cluster_name']).publish(label='A', enable=False)
        B = data('*Misses', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('stat', 'sum') and (not filter('CacheNodeId', '*'))).sum(by=['aws_region', 'aws_cache_cluster_name']).publish(label='B', enable=False)
        C = (A/(A+B)*100).publish(label='C')
    EOF
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
    display_name = "*Hits - Sum by aws_region,aws_cache_cluster_name"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    display_name = "*Misses - Sum by aws_region,aws_cache_cluster_name"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "hit rate %"
    label        = "C"
  }
}

resource "signalfx_time_chart" "sfx_aws_elasticache_items_by_cluster" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "# Items by Cluster"
  plot_type          = "LineChart"
  program_text       = "A = data('CurrItems', filter=filter('namespace', 'AWS/ElastiCache') and (not filter('CacheNodeId', '*')) and filter('CacheClusterId', '*') and filter('stat', 'upper')).sum(by=['aws_region', 'aws_cache_cluster_name']).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "count"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }

  viz_options {
    axis         = "left"
    display_name = "CurrItems - Sum by aws_region,aws_cache_cluster_name"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_elasticache_cpu_by_cluster" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Avg CPU% by Cluster"
  plot_type          = "LineChart"
  program_text       = "A = data('CPUUtilization', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('CacheNodeId', '*') and filter('stat', 'mean') and filter('aws_region', '*'), extrapolation='last_value', maxExtrapolations=5).mean(by=['aws_region', 'aws_cache_cluster_name']).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "cpu %"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }
}

resource "signalfx_time_chart" "sfx_aws_elasticache_cpu_by_node" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "CPU% by Node"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('CPUUtilization', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('CacheNodeId', '*') and filter('stat', 'mean') and filter('aws_region', '*'), extrapolation='last_value', maxExtrapolations=5).publish(label='A', enable=False)
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
    label     = "%"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
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

resource "signalfx_list_chart" "sfx_aws_elasticache_top_nodes_by_cpu" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 3
  name                    = "Top Nodes by CPU%"
  program_text            = "A = data('CPUUtilization', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('CacheNodeId', '*') and filter('stat', 'mean'), extrapolation='last_value', maxExtrapolations=5).mean(by=['aws_region', 'CacheClusterId', 'CacheNodeId']).top(count=5).publish(label='A')"
  secondary_visualization = "None"
  sort_by                 = "-value"
  unit_prefix             = "Metric"
}

resource "signalfx_time_chart" "sfx_aws_elasticache_swap_by_cluster" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "total swap used by all nodes in cluster"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "SwapUsage (bytes) by Cluster"
  plot_type          = "LineChart"
  program_text       = "A = data('SwapUsage', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('CacheNodeId', '*') and filter('stat', 'mean'), extrapolation='last_value', maxExtrapolations=5).sum(by=['aws_region', 'aws_cache_cluster_name']).publish(label='A')"
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
}

resource "signalfx_time_chart" "sfx_aws_elasticache_swap_by_node" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "SwapUsage (bytes) by Node"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('SwapUsage', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('CacheNodeId', '*') and filter('stat', 'mean') and filter('aws_region', '*'), extrapolation='last_value', maxExtrapolations=5).publish(label='A', enable=False)
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
    label     = "bytes"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
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

resource "signalfx_list_chart" "sfx_aws_elasticache_top_nodes_by_swap" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 4
  name                    = "Top Nodes by SwapUsage (bytes)"
  program_text            = "A = data('SwapUsage', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('CacheNodeId', '*') and filter('stat', 'mean') and filter('aws_region', '*'), extrapolation='last_value', maxExtrapolations=5).mean(by=['CacheClusterId', 'CacheNodeId', 'aws_region']).top(count=5).publish(label='A')"
  secondary_visualization = "None"
  sort_by                 = "-value"
  unit_prefix             = "Binary"
}

resource "signalfx_time_chart" "sfx_aws_elasticache_conns_by_cluster" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "total connections to all nodes in cluster"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "CurrConnections by Cluster"
  plot_type          = "LineChart"
  program_text       = "A = data('CurrConnections', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('CacheNodeId', '*') and filter('stat', 'mean')).sum(by=['aws_region', 'aws_cache_cluster_name']).publish(label='A')"
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 7200
  unit_prefix        = "Metric"

  axis_left {
    label     = "# connections"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
  }
}

resource "signalfx_time_chart" "sfx_aws_elasticache_conns_by_node" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "CurrConnections by Node"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('CurrConnections', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('CacheNodeId', '*') and filter('stat', 'mean') and filter('aws_region', '*'), extrapolation='last_value', maxExtrapolations=5).publish(label='A', enable=False)
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
    label     = "bytes"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
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

resource "signalfx_time_chart" "sfx_aws_elasticache_evictions" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "total evictions by all nodes in cluster"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Total Evictions/Min by Cluster"
  plot_type          = "LineChart"
  program_text       = "A = data('Evictions', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('CacheNodeId', '*') and filter('stat', 'mean')).sum(by=['aws_region', 'aws_cache_cluster_name']).publish(label='A')"
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
}

resource "signalfx_list_chart" "sfx_aws_elasticache_top_nodes_by_conns" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 4
  name                    = "Top Nodes by CurrConnections"
  program_text            = "A = data('CurrConnections', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('CacheNodeId', '*') and filter('stat', 'mean'), extrapolation='last_value', maxExtrapolations=5).mean(by=['CacheClusterId', 'CacheNodeId', 'aws_region']).top(count=5).publish(label='A')"
  secondary_visualization = "None"
  sort_by                 = "-value"
  unit_prefix             = "Metric"
}

resource "signalfx_time_chart" "sfx_aws_elasticache_evictions_by_node" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Evictions/Interval by Node"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('Evictions', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('CacheNodeId', '*') and filter('stat', 'mean') and filter('aws_region', '*'), extrapolation='last_value', maxExtrapolations=5).publish(label='A', enable=False)
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
    label     = "evictions/interval"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
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

resource "signalfx_list_chart" "sfx_aws_elasticache_top_nodes_by_evictions" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 4
  name                    = "Top Nodes by Evictions/Interval"
  program_text            = "A = data('Evictions', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('CacheNodeId', '*') and filter('stat', 'mean'), extrapolation='last_value', maxExtrapolations=5).mean(by=['CacheClusterId', 'CacheNodeId', 'aws_region']).top(count=5).publish(label='A')"
  secondary_visualization = "None"
  sort_by                 = "-value"
  unit_prefix             = "Metric"
}

resource "signalfx_time_chart" "sfx_aws_elasticache_net_bytes_by_cluster" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Total Network Bytes In/Interval by Cluster"
  plot_type          = "LineChart"
  program_text       = "A = data('NetworkBytesIn', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('CacheNodeId', '*') and filter('stat', 'mean')).sum(by=['aws_region', 'aws_cache_cluster_name']).publish(label='A')"
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
    display_name = "NetworkBytesIn"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_elasticache_net_bytes_by_node" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Network Bytes In/Interval by Node"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('NetworkBytesIn', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('CacheNodeId', '*') and filter('stat', 'mean') and filter('aws_region', '*'), extrapolation='last_value', maxExtrapolations=5).publish(label='A', enable=False)
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
    label     = "bytes/interval"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
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

resource "signalfx_list_chart" "sfx_aws_elasticache_top_nodes_by_net_bytes" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 4
  name                    = "Top Nodes by Network Bytes In/Interval"
  program_text            = "A = data('NetworkBytesIn', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('CacheNodeId', '*') and filter('stat', 'mean'), extrapolation='last_value', maxExtrapolations=5).mean(by=['CacheClusterId', 'CacheNodeId', 'aws_region']).top(count=5).publish(label='A')"
  secondary_visualization = "None"
  sort_by                 = "-value"
  unit_prefix             = "Binary"
}

resource "signalfx_time_chart" "sfx_aws_elasticache_net_bytes_out_by_cluster" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Total Network Bytes Out/Interval by Cluster"
  plot_type          = "LineChart"
  program_text       = "A = data('NetworkBytesOut', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('CacheNodeId', '*') and filter('stat', 'mean')).sum(by=['aws_region', 'aws_cache_cluster_name']).publish(label='A')"
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
    display_name = "NetworkBytesIn"
    label        = "A"
  }
}

resource "signalfx_time_chart" "sfx_aws_elasticache_net_bytes_out_by_node" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Network Bytes Out/Interval by Node"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('NetworkBytesOut', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('CacheNodeId', '*') and filter('stat', 'mean') and filter('aws_region', '*'), extrapolation='last_value', maxExtrapolations=5).publish(label='A', enable=False)
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
    label     = "bytes/interval"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
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

resource "signalfx_list_chart" "sfx_aws_elasticache_top_nodes_by_net_bytes_out" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 4
  name                    = "Top Nodes by Network Bytes Out/Interval"
  program_text            = "A = data('NetworkBytesOut', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('CacheNodeId', '*') and filter('stat', 'mean'), extrapolation='last_value', maxExtrapolations=5).mean(by=['CacheClusterId', 'CacheNodeId', 'aws_region']).top(count=5).publish(label='A')"
  secondary_visualization = "None"
  sort_by                 = "-value"
  unit_prefix             = "Binary"
}

resource "signalfx_time_chart" "sfx_aws_elasticache_freeable_by_cluster" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "total freeable memory across all nodes in cluster"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "FreeableMemory (bytes) by Cluster"
  plot_type          = "LineChart"
  program_text       = "A = data('FreeableMemory', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('CacheNodeId', '*') and filter('stat', 'mean'), extrapolation='last_value', maxExtrapolations=5).sum(by=['aws_region', 'aws_cache_cluster_name']).publish(label='A')"
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
}

resource "signalfx_time_chart" "sfx_aws_elasticache_freeable_by_node" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Dimension"
  description        = "percentile distribution"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "FreeableMemory (bytes) by Node"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('FreeableMemory', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('CacheNodeId', '*') and filter('stat', 'mean') and filter('aws_region', '*'), extrapolation='last_value', maxExtrapolations=5).publish(label='A', enable=False)
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
    label     = "bytes"
    min_value = 0
  }

  histogram_options {
    color_theme = "red"
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

resource "signalfx_list_chart" "sfx_aws_elasticache_freeable_top" {
  color_by                = "Dimension"
  disable_sampling        = false
  max_precision           = 4
  name                    = "Nodes with Least FreeableMemory (bytes)"
  program_text            = "A = data('FreeableMemory', filter=filter('namespace', 'AWS/ElastiCache') and filter('CacheClusterId', '*') and filter('CacheNodeId', '*') and filter('stat', 'mean'), extrapolation='last_value', maxExtrapolations=5).mean(by=['CacheClusterId', 'CacheNodeId', 'aws_region']).top(count=5).publish(label='A')"
  secondary_visualization = "None"
  sort_by                 = "+value"
  unit_prefix             = "Binary"
}

resource "signalfx_dashboard" "sfx_aws_elasticache" {

  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.sfx_aws_elasticache.id
  name              = "ElastiCache"

  variable {
    alias                  = "cluster id"
    apply_if_exist         = false
    description            = "ElastiCache Cluster Id as displayed in the AWS API"
    property               = "CacheClusterId"
    replace_only           = false
    restricted_suggestions = false
    value_required         = false
    values                 = []
    values_suggested       = []
  }
  variable {
    alias                  = "cluster name"
    apply_if_exist         = false
    description            = "The name  of the cluster as displayed in AWS"
    property               = "aws_cache_cluster_name"
    replace_only           = false
    restricted_suggestions = false
    value_required         = false
    values                 = []
    values_suggested       = []
  }
  variable {
    alias                  = "region"
    apply_if_exist         = false
    description            = "AWS Region"
    property               = "aws_region"
    replace_only           = false
    restricted_suggestions = false
    value_required         = false
    values                 = []
    values_suggested       = []
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_elasticache_clusters.id
    row      = 0
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_single_value_chart.sfx_aws_elasticache_nodes.id
    row      = 0
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_elasticache_nodes_per_cluster.id
    row      = 0
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elasticache_hits_misses.id
    row      = 1
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elasticache_overall_hit_rate.id
    row      = 1
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elasticache_items_by_cluster.id
    row      = 1
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elasticache_cpu_by_cluster.id
    row      = 2
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elasticache_cpu_by_node.id
    row      = 2
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_elasticache_top_nodes_by_cpu.id
    row      = 2
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elasticache_swap_by_cluster.id
    row      = 3
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elasticache_swap_by_node.id
    row      = 3
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_elasticache_top_nodes_by_swap.id
    row      = 3
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elasticache_conns_by_cluster.id
    row      = 4
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elasticache_conns_by_node.id
    row      = 4
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_elasticache_top_nodes_by_conns.id
    row      = 4
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elasticache_evictions.id
    row      = 5
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elasticache_evictions_by_node.id
    row      = 5
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_elasticache_top_nodes_by_evictions.id
    row      = 5
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elasticache_net_bytes_by_cluster.id
    row      = 6
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elasticache_net_bytes_by_node.id
    row      = 6
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_elasticache_top_nodes_by_net_bytes.id
    row      = 6
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elasticache_net_bytes_out_by_cluster.id
    row      = 7
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elasticache_net_bytes_out_by_node.id
    row      = 7
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_elasticache_top_nodes_by_net_bytes_out.id
    row      = 7
    column   = 8
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elasticache_freeable_by_cluster.id
    row      = 8
    column   = 0
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_time_chart.sfx_aws_elasticache_freeable_by_node.id
    row      = 8
    column   = 4
    height   = 1
    width    = 4
  }

  chart {
    chart_id = signalfx_list_chart.sfx_aws_elasticache_freeable_top.id
    row      = 8
    column   = 8
    height   = 1
    width    = 4
  }
}
