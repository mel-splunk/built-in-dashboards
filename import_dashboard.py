#!/usr/bin/env python3
import argparse
import os
import re
import signalfx
import string
import subprocess
import sys
import tempfile

parser = argparse.ArgumentParser(description='Export a SignalFx asset as Terraform')
parser.add_argument('--key', dest='key', required=True, help='An API key for accessing SignalFx')
parser.add_argument('--api_url', dest='api_url', help='The API URL, used for non-default realms', default='https://api.us0.signalfx.com')
parser.add_argument('--name', dest='name', required=True, help='The name of the resource after export, e.g. mychart0')
parser.add_argument('--id', dest='id', required=True, help='The ID of the asset in SignalFx')
parser.add_argument('--exclude', dest='excludes', nargs='*', help='A field to exclude from the emitted HCL', default=['id', 'url', 'tags'])

args = vars(parser.parse_args())

def init_terraform(tdir, key, api_url, resource, name):
    with open('main.tf', 'w') as tffile:
        tffile.write('provider "signalfx" {\n')
        tffile.write(f'\tauth_token = "{key}"\n')
        tffile.write('}\n')
        tffile.write(f'resource "{resource}" "{name}" {{\n')
        tffile.write('}\n')
    subprocess.check_output(['terraform', 'init'])

def import_resource(tdir, resource, name, id):
    subprocess.check_output(['terraform', 'import', f'{resource}.{name}', id])

def export_resource(tdir, resource, name):
    output = subprocess.check_output(['terraform', 'state', 'show', '-no-color', f'{resource}.{name}'])
    return output

def handle_asset(key, api_url, resource, name, id):
    currdir = os.getcwd()
    output = None
    with tempfile.TemporaryDirectory() as tmpdirname:
        os.chdir(tmpdirname)
        init_terraform(tmpdirname, key, api_url, resource, name)
        import_resource(tmpdirname, resource, name, id)
        output = export_resource(tmpdirname, resource, name)
    os.chdir(currdir)
    return output

# Handles replacing various problematic bits of output. Some are computed fields, others are problematic parts of an export.
def filter_hcl(hcl):

    # Look for a bare label in viz_options, which seems to break stuff.
    hcl = re.sub('viz_options\s*\{\n\s*label\s*=\s\".*\"\n\s*\s}\n', '', hcl)
    # Replace the EOT thing that doesn't work with an EOF
    hcl = re.sub('<<~EOT', '<<-EOF', hcl)
    hcl = re.sub('EOT', 'EOF', hcl)

    keep = list()
    if len(args['excludes']) < 1:
        return hcl
    for line in hcl.splitlines():
        exclude = False
        for ex in args['excludes']:
            regex = f'^\s*{ex}\s*='
            match = re.search(regex, line)
            if match:
                exclude = True
                break
            # This catches the silly fixed "max" fields that come out of the
            # import but are not meant to be in the config itself. - Cory
            if "17976931348623157" in line:
                exclude = True
                break
        if not exclude:
            keep.append(line)
    return "\n".join(keep)

def replace_chart_ids(hcl, charts):
    for id, name in charts.items():
        hcl = hcl.replace(f'"{id}"', name)
    return hcl

with signalfx.SignalFx(
    api_endpoint=args['api_url'],
).rest(args['key']) as sfx:
    dash = sfx.get_dashboard(args['id'])

    # I am not certain of the API guarantees that these will come in a sane
    # order so we'll just sort it for human readability.
    charts = sorted(dash["charts"], key=lambda k: (k["row"], k["column"]))

    chart_types = []
    chart_ids = {}
    # Iterate through and fetch each chart
    for i, chart in enumerate(charts):
        api_chart = sfx.get_chart(chart["chartId"])
        chart_type = api_chart["options"]["type"]
        tf_type = "signalfx_time_chart"
        if chart_type == "SingleValue":
            tf_type = "signalfx_single_value_chart"
        elif chart_type == "List":
            tf_type = "signalfx_list_chart"
        elif chart_type == "Text":
            tf_type = "signalfx_text_chart"
        elif chart_type == "TimeSeriesChart":
            tf_type = "signalfx_time_chart"
        elif chart_type == "Heatmap":
            tf_type = "signalfx_heatmap_chart"
        else:
            print(f"Exiting: Unknown chart type {chart_type}", file=sys.stderr)
            sys.exit()

        chart_types.append(tf_type)
        tf_name = args['name'] + "_" + f"{i}"
        chart_ids[chart['chartId']] = f"{tf_type}.{tf_name}"

        output = handle_asset(args['key'], args['api_url'], tf_type, tf_name, chart['chartId'])
        if output != None:
            print(filter_hcl(output.decode('utf-8')))


    dout = handle_asset(args['key'], args['api_url'], 'signalfx_dashboard', args['name'], args['id'])
    if output != None:
        print(replace_chart_ids(dout.decode('utf-8'), chart_ids))
