variable "sfx_token" {
  description = "Your SignalFx token"
}

provider "signalfx" {
  auth_token = var.sfx_token
}

module "aws_alb" {
  source = "./aws_alb"
}

module "aws_api_gateway" {
  source = "./aws_api_gateway"
}

module "aws_asg" {
  source = "./aws_asg"
}

module "aws_ebs" {
  source = "./aws_ebs"
}

module "aws_ec2" {
  source = "./aws_ec2"
}
