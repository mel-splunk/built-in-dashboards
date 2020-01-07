variable "sfx_token" {
  description = "Your SignalFx token"
}

provider "signalfx" {
  auth_token = var.sfx_token
}

module "aws_ec2" {
  source = "./aws_ec2"
}
