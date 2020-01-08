# SignalFx Built-In Dashboards

This is a Terraform project containing the "built in" dashboards in SignalFx.

You can use these Terraform definitions to either submit improvements to the SignalFx dashboards, to see how they are made, or to make your own versions in your organization.

# Structure

Each "integration" is contained in a module. For example the AWS EC2 integration is contained in the "aws_ec2" directory. Any associated dashboards groups are specified therein. The convention is that each dashboard gets it's own tf file.

# Using It

Using this repo you can `terraform apply` yourself a full copy of all the dashboards as a sort of staging environment. This will, of course, not replace the actual built-in content of SignalFx. That process is internal to SignalFx.

You'll need to provide the var `sfx_token` to use this. I recommend using a `terraform.tfvars` file, which is already in the `.gitignore` for frequent users.

# Importer

There is an included `import_dashboard.py` script which aims to reduce the effort of importing an existing dashboard. I say reduce because it only automates a portion.

```
# You can setup a virtualenv and such, use `requirements.txt`
python import_dashboard.py SFX_KEY dashboardId dashboardName > scratchdir/main.tf
```

The output of this command is of the shape suitable for `terraform import`. Since this command can only work on single resources we've now got to do the rest of the work by hand. The output looks like:

```
terraform import signalfx_time_chart.sfx_aws_ec2_instances_0 DjJ6LAIAcAA
resource "signalfx_time_chart" "sfx_aws_ec2_instances_0" {
}
# repeated many times
resource "signalfx_dashboard" "signalfx_aws_ec2_instances" {
  chart {
    # Each chart here, repeated
  }
}
```

You can then cut and paste the `signalfx_dashboard` section to your *real* working directory and comment out all the other lines and begin a process that looks like this:

```
# copy the terraform import line
$ terraform import signalfx_time_chart.sfx_aws_ec2_instances_0 DjJ6LAIAcAA
signalfx_time_chart.sfx_aws_ec2_instances_0: Importing from ID "DjJ6LAIAcAA"...
signalfx_time_chart.sfx_aws_ec2_instances_0: Import prepared!
  Prepared signalfx_time_chart for import
signalfx_time_chart.sfx_aws_ec2_instances_0: Refreshing state... [id=DjJ6LAIAcAA]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform
# Now grab the imported state
$ terraform state show signalfx_time_chart.sfx_aws_ec2_instances_0
# Copy the output and plop it into your working directory
# be sure to remove `id` and `url` attributes.
```
