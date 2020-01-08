import signalfx
import sys

key = sys.argv[1]
dashboard_id = sys.argv[2]
dashboard_name = sys.argv[3]

with signalfx.SignalFx(
    api_endpoint='https://api.us0.signalfx.com',
).rest(key) as sfx:
    dash = sfx.get_dashboard(dashboard_id)

    # I am not certain of the API guarantees that these will come in a sane
    # order so we'll just sort it for human readability.
    charts = sorted(dash["charts"], key=lambda k: (k["row"], k["column"]))

    chart_types = []
    # Iterate through and fetch each chart
    for i, chart in enumerate(charts):
        api_chart = sfx.get_chart(chart["chartId"])
        chart_type = api_chart["options"]["type"]
        tf_type = "signalfx_time_chart"
        if chart_type == "SingleValue":
            tf_type = "signalfx_single_value_chart"
        elif chart_type == "List":
            tf_type = "signalfx_list_chart"
        elif chart_type == "TimeSeriesChart":
            tf_type = "signalfx_time_chart"
        else:
            print(f"Unknown chart type {chart_type}, exiting")
            sys.exit()

        chart_types.append(tf_type)

        print(f"""terraform import {tf_type}.{dashboard_name}_{i} {chart["chartId"]}""")
        print(f"""resource "{tf_type}" "{dashboard_name}_{i}" {{""")
        print("""}""")


    print(f"""resource "signalfx_dashboard" "{dashboard_name}" {{""")
    print(f"""\tname = "{dash["name"]}"""")

    for i, chart in enumerate(charts):
        print("""\tchart {""")
        print(f"""\t\tchart_id = {chart_types[i]}.{dashboard_name}_{i}.id""")
        print(f"""\t\trow = {chart["row"]}""")
        print(f"""\t\tcolumn = {chart["column"]}""")
        print(f"""\t\theight = {chart["height"]}""")
        print(f"""\t\twidth = {chart["width"]}""")
        print("""\t}\n""")

    print("""}""")
