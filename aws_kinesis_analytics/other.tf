resource "signalfx_dashboard" "sfx_aws_kinesis_analytics_other" {
  variable {
          alias                  = "AWSUniqueId"
          apply_if_exist         = false
          property               = "AWSUniqueId"
          replace_only           = false
          restricted_suggestions = false
          value_required         = false
          values                 = []
          values_suggested       = []
      }
      variable {
          alias                  = "application"
          apply_if_exist         = false
          property               = "Application"
          replace_only           = false
          restricted_suggestions = false
          value_required         = false
          values                 = []
          values_suggested       = []
      }

	name = "Kinesis Analytics"
	chart {
		chart_id = signalfx_time_chart.sfx_aws_kinesis_analytics_other_0.id
		row = 0
		column = 0
		height = 1
		width = 6
	}

	chart {
		chart_id = signalfx_single_value_chart.sfx_aws_kinesis_analytics_other_1.id
		row = 0
		column = 6
		height = 1
		width = 3
	}

	chart {
		chart_id = signalfx_single_value_chart.sfx_aws_kinesis_analytics_other_2.id
		row = 0
		column = 9
		height = 1
		width = 3
	}

	chart {
		chart_id = signalfx_single_value_chart.sfx_aws_kinesis_analytics_other_3.id
		row = 1
		column = 0
		height = 1
		width = 3
	}

	chart {
		chart_id = signalfx_single_value_chart.sfx_aws_kinesis_analytics_other_4.id
		row = 1
		column = 3
		height = 1
		width = 3
	}

	chart {
		chart_id = signalfx_time_chart.sfx_aws_kinesis_analytics_other_5.id
		row = 1
		column = 6
		height = 1
		width = 6
	}

	chart {
		chart_id = signalfx_single_value_chart.sfx_aws_kinesis_analytics_other_6.id
		row = 2
		column = 0
		height = 1
		width = 3
	}

	chart {
		chart_id = signalfx_single_value_chart.sfx_aws_kinesis_analytics_other_7.id
		row = 2
		column = 3
		height = 1
		width = 3
	}

	chart {
		chart_id = signalfx_time_chart.sfx_aws_kinesis_analytics_other_8.id
		row = 2
		column = 6
		height = 1
		width = 6
	}

	chart {
		chart_id = signalfx_time_chart.sfx_aws_kinesis_analytics_other_9.id
		row = 3
		column = 0
		height = 1
		width = 4
	}

	chart {
		chart_id = signalfx_time_chart.sfx_aws_kinesis_analytics_other_10.id
		row = 3
		column = 4
		height = 1
		width = 4
	}

	chart {
		chart_id = signalfx_time_chart.sfx_aws_kinesis_analytics_other_11.id
		row = 3
		column = 8
		height = 1
		width = 4
	}

	chart {
		chart_id = signalfx_single_value_chart.sfx_aws_kinesis_analytics_other_12.id
		row = 4
		column = 0
		height = 1
		width = 2
	}

	chart {
		chart_id = signalfx_time_chart.sfx_aws_kinesis_analytics_other_13.id
		row = 4
		column = 2
		height = 1
		width = 5
	}

	chart {
		chart_id = signalfx_time_chart.sfx_aws_kinesis_analytics_other_14.id
		row = 4
		column = 7
		height = 1
		width = 5
	}

}
