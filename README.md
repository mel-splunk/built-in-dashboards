# SignalFx Built-In Dashboards

This is a Terraform project containing the "built in" dashboards in SignalFx.

You can use these Terraform definitions to either submit improvements to the SignalFx dashboards, to see how they are made, or to make your own versions in your organization.

# Structure

Each "integration" is contained in a module. For example the AWS EC2 integration is contained in the "aws_ec2" directory. Any associated dashboards groups are specified therein. The convention is that each dashboard gets its own tf file.

# Using It

Using this repo you can `terraform apply` yourself a full copy of all the dashboards as a sort of staging environment. This will, of course, not replace the actual built-in content of SignalFx. That process is internal to SignalFx.

You'll need to provide the var `sfx_token` to use this. I recommend using a `terraform.tfvars` file, which is already in the `.gitignore` for frequent users.

# Exporter

There is an included `export_dashboard.py` script which aims to reduce the effort of export an existing dashboard.

```
usage: export_dashboard.py [-h] --key KEY [--api_url API_URL] --name NAME --id
                           ID [--exclude [EXCLUDES [EXCLUDES ...]]]

Export a SignalFx asset as Terraform

optional arguments:
  -h, --help            show this help message and exit
  --key KEY             An API key for accessing SignalFx
  --api_url API_URL     The API URL, used for non-default realms
  --name NAME           The name of the resource after export, e.g. mychart0
  --id ID               The ID of the asset in SignalFx
  --exclude [EXCLUDES [EXCLUDES ...]]
                        A field to exclude from the emitted HCL
```

Here's an example:

```
# You can setup a virtualenv and such, use `requirements.txt`
python export_dashboard.py --key XxX --id DjJ6MCMAgAA --name sfx_aws_sqs_queue
```

This command will recursively export each individual chart in a dashboard group. And emit a dashboard definition where these charts are referred to by their Terraform resource name.

## Notes

The exporter does some regex surgery out the outputted HCL. By default it excludes computed fields `id` and `url` as well as the problematic `tags` field, which is deprecated. It also removes the "bounds" values for axes that are just fixed values and bare `viz_options` fields that only specify a label and no other information. The latter can cause weird problems on creation.
