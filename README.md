# SignalFx Built-In Dashboards

This is a Terraform project containing the "built in" dashboards in SignalFx.

You can use these Terraform definitions to either submit improvements to the SignalFx dashboards, to see how they are made, or to make your own versions in your organization.

# Structure

Each "integration" is contained in a module. For example the AWS EC2 integration is contained in the "aws_ec2" directory. Any associated dashboards groups are specified therein. The convention is that each dashboard gets it's own tf file.

# Using It

Using this repo you can `terraform apply` yourself a full copy of all the dashboards as a sort of staging environment. This will, of course, not replace the actual built-in content of SignalFx. That process is internal to SignalFx.

You'll need to provide the var `sfx_token` to use this. I recommend using a `terraform.tfvars` file, which is already in the `.gitignore`, for frequent users.
