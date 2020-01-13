resource "signalfx_single_value_chart" "sfx_aws_api_gateway_api_resource_call_count_single" {
    color_by                = "Dimension"
    description             = "Number of API calls in 5 minutes intervals"
    max_delay               = 0
    max_precision           = 0
    name                    = "API Calls"
    program_text            = "A = data('Count', filter=filter('stat', 'count'), rollup='latest').sum().publish(label='A')"
    secondary_visualization = "None"
    show_spark_line         = false
    unit_prefix             = "Metric"

    viz_options {
        display_name = "Number of API calls in 5 minutes intervals (GET)"
        label        = "A"
    }
}

resource "signalfx_time_chart" "sfx_aws_api_gateway_api_resource_call_count" {
    axes_include_zero         = true
    axes_precision            = 0
    color_by                  = "Dimension"
    description               = "Number of API calls in 5 minutes intervals by HTTP method"
    disable_sampling          = false
    max_delay                 = 0
    minimum_resolution        = 0
    name                      = "API Calls"
    on_chart_legend_dimension = "Method"
    plot_type                 = "AreaChart"
    program_text              = "A = data('Count', filter=filter('stat', 'count'), rollup='latest').sum(by=['Method']).publish(label='A')"
    show_data_markers         = false
    show_event_lines          = false
    stacked                   = true
    time_range                = 900
    unit_prefix               = "Metric"

    histogram_options {
        color_theme = "red"
    }

    legend_options_fields {
        enabled  = true
        property = "ApiName"
    }
    legend_options_fields {
        enabled  = false
        property = "AWSUniqueId"
    }
    legend_options_fields {
        enabled  = true
        property = "Method"
    }
    legend_options_fields {
        enabled  = false
        property = "sf_originatingMetric"
    }
    legend_options_fields {
        enabled  = false
        property = "namespace"
    }
    legend_options_fields {
        enabled  = false
        property = "sf_metric"
    }
    legend_options_fields {
        enabled  = true
        property = "Resource"
    }
    legend_options_fields {
        enabled  = false
        property = "Stage"
    }
    legend_options_fields {
        enabled  = false
        property = "stat"
    }

    viz_options {
        axis         = "left"
        display_name = "Number of API calls in 5 minutes intervals (GET)"
        label        = "A"
    }
}

resource "signalfx_single_value_chart" "sfx_aws_api_gateway_api_resource_cache_hits_pct" {
    color_by                = "Dimension"
    description             = "Percent cache hits for GET method in 5 minute intervals"
    max_delay               = 0
    max_precision           = 2
    name                    = "Percent Cache Hits"
    program_text            = <<-EOF
        A = data('CacheHitCount', filter=filter('stat', 'sum'), rollup='latest').publish(label='A', enable=False)
        B = data('CacheMissCount', filter=filter('stat', 'sum'), rollup='latest').publish(label='B', enable=False)
        C = (100*A/(A+B)).publish(label='C')
    EOF
    refresh_interval        = 5
    secondary_visualization = "None"
    show_spark_line         = false
    unit_prefix             = "Metric"

    viz_options {
        display_name = "Percent Cache Hit"
        label        = "C"
        value_suffix = "%"
    }
    viz_options {
        color        = "emerald"
        display_name = "Cache Hit Count"
        label        = "A"
    }
    viz_options {
        color        = "orange"
        display_name = "Cache Miss Count"
        label        = "B"
    }
}

resource "signalfx_time_chart" "sfx_aws_api_gateway_api_resource_cache_hits" {
    axes_include_zero         = false
    axes_precision            = 0
    color_by                  = "Dimension"
    description               = "Number of cache hits and misses for GET method in 5 minute intervals"
    disable_sampling          = false
    max_delay                 = 0
    minimum_resolution        = 0
    name                      = "Cache Hits and Misses"
    on_chart_legend_dimension = "plot_label"
    plot_type                 = "AreaChart"
    program_text              = <<-EOF
        A = data('CacheHitCount', filter=filter('stat', 'sum'), rollup='latest').publish(label='A')
        B = data('CacheMissCount', filter=filter('stat', 'sum'), rollup='latest').publish(label='B')
    EOF
    show_data_markers         = false
    show_event_lines          = false
    stacked                   = true
    time_range                = 900
    unit_prefix               = "Metric"

    histogram_options {
        color_theme = "red"
    }

    viz_options {
        axis         = "left"
        color        = "blue"
        display_name = "Hits"
        label        = "A"
    }
    viz_options {
        axis         = "left"
        color        = "purple"
        display_name = "Misses"
        label        = "B"
    }
}

resource "signalfx_time_chart" "sfx_aws_api_gateway_api_resource_4xx_errors" {
    axes_include_zero         = true
    axes_precision            = 0
    color_by                  = "Dimension"
    description               = "Number of 4XX errors in 5 minute intervals by HTTP method"
    disable_sampling          = false
    max_delay                 = 0
    minimum_resolution        = 0
    name                      = "4XX Errors"
    on_chart_legend_dimension = "Method"
    plot_type                 = "ColumnChart"
    program_text              = "A = data('4XXError', filter=filter('stat', 'sum'), rollup='latest').publish(label='A')"
    show_data_markers         = false
    show_event_lines          = false
    stacked                   = true
    time_range                = 900
    unit_prefix               = "Metric"

    histogram_options {
        color_theme = "red"
    }

    legend_options_fields {
        enabled  = true
        property = "ApiName"
    }
    legend_options_fields {
        enabled  = false
        property = "AWSUniqueId"
    }
    legend_options_fields {
        enabled  = true
        property = "Method"
    }
    legend_options_fields {
        enabled  = false
        property = "sf_originatingMetric"
    }
    legend_options_fields {
        enabled  = false
        property = "namespace"
    }
    legend_options_fields {
        enabled  = false
        property = "sf_metric"
    }
    legend_options_fields {
        enabled  = false
        property = "Resource"
    }
    legend_options_fields {
        enabled  = false
        property = "Stage"
    }
    legend_options_fields {
        enabled  = false
        property = "stat"
    }

    viz_options {
        axis         = "left"
        display_name = "4XXError (GET)"
        label        = "A"
    }
}

resource "signalfx_list_chart" "sfx_aws_api_gateway_api_resource_latency" {
    color_by                = "Dimension"
    description             = "The time between when API Gateway receives a request from a client and when it returns a response to the client"
    disable_sampling        = false
    max_delay               = 0
    max_precision           = 0
    name                    = "Latency"
    program_text            = "A = data('Latency', filter=filter('stat', 'mean') and filter('Method', '*'), rollup='latest').publish(label='A')"
    secondary_visualization = "Sparkline"
    sort_by                 = "+Method"
    time_range              = 900
    unit_prefix             = "Metric"

    legend_options_fields {
        enabled  = false
        property = "ApiName"
    }
    legend_options_fields {
        enabled  = false
        property = "AWSUniqueId"
    }
    legend_options_fields {
        enabled  = true
        property = "Method"
    }
    legend_options_fields {
        enabled  = false
        property = "sf_originatingMetric"
    }
    legend_options_fields {
        enabled  = false
        property = "namespace"
    }
    legend_options_fields {
        enabled  = false
        property = "sf_metric"
    }
    legend_options_fields {
        enabled  = false
        property = "Resource"
    }
    legend_options_fields {
        enabled  = false
        property = "Stage"
    }
    legend_options_fields {
        enabled  = false
        property = "stat"
    }

    viz_options {
        display_name = "Latency (GET)"
        label        = "A"
        value_unit   = "Millisecond"
    }
}

resource "signalfx_list_chart" "sfx_aws_api_gateway_api_resource_integration_latency" {
    color_by                = "Dimension"
    description             = "The time between when API Gateway relays a request to the back end and when it receives a response from the back end"
    disable_sampling        = false
    max_delay               = 0
    max_precision           = 0
    name                    = "Integration Latency"
    program_text            = "A = data('IntegrationLatency', filter=filter('stat', 'mean') and filter('Method', '*'), rollup='latest').publish(label='A')"
    secondary_visualization = "Sparkline"
    sort_by                 = "+Method"
    time_range              = 900
    unit_prefix             = "Metric"

    legend_options_fields {
        enabled  = false
        property = "ApiName"
    }
    legend_options_fields {
        enabled  = false
        property = "AWSUniqueId"
    }
    legend_options_fields {
        enabled  = true
        property = "Method"
    }
    legend_options_fields {
        enabled  = false
        property = "sf_originatingMetric"
    }
    legend_options_fields {
        enabled  = false
        property = "namespace"
    }
    legend_options_fields {
        enabled  = false
        property = "sf_metric"
    }
    legend_options_fields {
        enabled  = false
        property = "Resource"
    }
    legend_options_fields {
        enabled  = false
        property = "Stage"
    }
    legend_options_fields {
        enabled  = false
        property = "stat"
    }

    viz_options {
        display_name = "Integration Latency (GET)"
        label        = "A"
        value_unit   = "Millisecond"
    }
}

# signalfx_time_chart.sfx_aws_api_gateway_api_resource_7:
resource "signalfx_time_chart" "sfx_aws_api_gateway_api_resource_5xx" {
    axes_include_zero         = true
    axes_precision            = 0
    color_by                  = "Dimension"
    description               = "Number of 5XX errors in 5 minute intervals by HTTP method"
    disable_sampling          = false
    max_delay                 = 0
    minimum_resolution        = 0
    name                      = "5XX Errors"
    on_chart_legend_dimension = "Method"
    plot_type                 = "ColumnChart"
    program_text              = "A = data('5XXError', filter=filter('stat', 'sum'), rollup='latest').publish(label='A')"
    show_data_markers         = false
    show_event_lines          = false
    stacked                   = true
    time_range                = 900
    unit_prefix               = "Metric"

    histogram_options {
        color_theme = "red"
    }

    legend_options_fields {
        enabled  = true
        property = "ApiName"
    }
    legend_options_fields {
        enabled  = false
        property = "AWSUniqueId"
    }
    legend_options_fields {
        enabled  = true
        property = "Method"
    }
    legend_options_fields {
        enabled  = false
        property = "sf_originatingMetric"
    }
    legend_options_fields {
        enabled  = false
        property = "namespace"
    }
    legend_options_fields {
        enabled  = false
        property = "sf_metric"
    }
    legend_options_fields {
        enabled  = false
        property = "Resource"
    }
    legend_options_fields {
        enabled  = false
        property = "Stage"
    }
    legend_options_fields {
        enabled  = false
        property = "stat"
    }

    viz_options {
        axis         = "left"
        display_name = "5XXError (GET)"
        label        = "A"
    }
}

resource "signalfx_dashboard" "sfx_aws_api_gateway_api_resource" {
  charts_resolution = "default"
  dashboard_group = signalfx_dashboard_group.sfx_aws_api_gateway.id
  description       = "Charts for a single AWS API Gateway resource"
  name              = "API Resource"

  variable {
          alias                  = "Resource"
          apply_if_exist         = false
          property               = "Resource"
          replace_only           = false
          restricted_suggestions = false
          value_required         = true
          values                 = ["Choose resource"]
          values_suggested       = []
  }

	chart {
		chart_id = signalfx_single_value_chart.sfx_aws_api_gateway_api_resource_call_count_single.id
		row = 0
		column = 0
		height = 1
		width = 4
	}

	chart {
		chart_id = signalfx_time_chart.sfx_aws_api_gateway_api_resource_call_count.id
		row = 0
		column = 4
		height = 1
		width = 8
	}

	chart {
		chart_id = signalfx_single_value_chart.sfx_aws_api_gateway_api_resource_cache_hits_pct.id
		row = 1
		column = 0
		height = 1
		width = 4
	}

	chart {
		chart_id = signalfx_time_chart.sfx_aws_api_gateway_api_resource_cache_hits.id
		row = 1
		column = 4
		height = 1
		width = 8
	}

	chart {
		chart_id = signalfx_time_chart.sfx_aws_api_gateway_api_resource_4xx_errors.id
		row = 2
		column = 0
		height = 1
		width = 6
	}

	chart {
		chart_id = signalfx_list_chart.sfx_aws_api_gateway_api_resource_latency.id
		row = 2
		column = 6
		height = 2
		width = 3
	}

	chart {
		chart_id = signalfx_list_chart.sfx_aws_api_gateway_api_resource_integration_latency.id
		row = 2
		column = 9
		height = 2
		width = 3
	}

	chart {
		chart_id = signalfx_time_chart.sfx_aws_api_gateway_api_resource_5xx.id
		row = 3
		column = 0
		height = 1
		width = 6
	}
}
