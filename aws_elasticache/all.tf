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

  # 	chart {
  # 		chart_id = signalfx_single_value_chart.sfx_aws_elasticache_1.id
  # 		row = 0
  # 		column = 4
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_list_chart.sfx_aws_elasticache_2.id
  # 		row = 0
  # 		column = 8
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_time_chart.sfx_aws_elasticache_3.id
  # 		row = 1
  # 		column = 0
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_time_chart.sfx_aws_elasticache_4.id
  # 		row = 1
  # 		column = 4
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_time_chart.sfx_aws_elasticache_5.id
  # 		row = 1
  # 		column = 8
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_time_chart.sfx_aws_elasticache_6.id
  # 		row = 2
  # 		column = 0
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_time_chart.sfx_aws_elasticache_7.id
  # 		row = 2
  # 		column = 4
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_list_chart.sfx_aws_elasticache_8.id
  # 		row = 2
  # 		column = 8
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_time_chart.sfx_aws_elasticache_9.id
  # 		row = 3
  # 		column = 0
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_time_chart.sfx_aws_elasticache_10.id
  # 		row = 3
  # 		column = 4
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_list_chart.sfx_aws_elasticache_11.id
  # 		row = 3
  # 		column = 8
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_time_chart.sfx_aws_elasticache_12.id
  # 		row = 4
  # 		column = 0
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_time_chart.sfx_aws_elasticache_13.id
  # 		row = 4
  # 		column = 4
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_list_chart.sfx_aws_elasticache_14.id
  # 		row = 4
  # 		column = 8
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_time_chart.sfx_aws_elasticache_15.id
  # 		row = 5
  # 		column = 0
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_time_chart.sfx_aws_elasticache_16.id
  # 		row = 5
  # 		column = 4
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_list_chart.sfx_aws_elasticache_17.id
  # 		row = 5
  # 		column = 8
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_time_chart.sfx_aws_elasticache_18.id
  # 		row = 6
  # 		column = 0
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_time_chart.sfx_aws_elasticache_19.id
  # 		row = 6
  # 		column = 4
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_list_chart.sfx_aws_elasticache_20.id
  # 		row = 6
  # 		column = 8
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_time_chart.sfx_aws_elasticache_21.id
  # 		row = 7
  # 		column = 0
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_time_chart.sfx_aws_elasticache_22.id
  # 		row = 7
  # 		column = 4
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_list_chart.sfx_aws_elasticache_23.id
  # 		row = 7
  # 		column = 8
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_time_chart.sfx_aws_elasticache_24.id
  # 		row = 8
  # 		column = 0
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_time_chart.sfx_aws_elasticache_25.id
  # 		row = 8
  # 		column = 4
  # 		height = 1
  # 		width = 4
  # 	}
  #
  # 	chart {
  # 		chart_id = signalfx_list_chart.sfx_aws_elasticache_26.id
  # 		row = 8
  # 		column = 8
  # 		height = 1
  # 		width = 4
  # 	}
  #
}
