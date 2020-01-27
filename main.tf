variable "sfx_tokens" {
  description = "Your SignalFx token"
  type = map
  default = {
    "default" = ""
    "personal" = ""
    "lab" = ""
  }
}

variable "sfx_api_urls" {
  description = "URL for API"
  type = map
  default = {
    "default" = "https://app.us0.signalfx.com"
    "personal" = "https://app.signalfx.com"
    "lab" = "https://app.signalfx.com"
  }
}

variable "sfx_custom_urls" {
  description = "URL for API"
  type = map
  default = {
    "default" = "https://sfdemo.signalfx.com"
    "personal" = "https://app.signalfx.com"
    "lab" = "https://app.signalfx.com"
  }
}

provider "signalfx" {
  auth_token = var.sfx_tokens[terraform.workspace]
  api_url = var.sfx_api_urls[terraform.workspace]
  custom_app_url = var.sfx_custom_urls[terraform.workspace]
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

module "aws_cloudfront" {
  source = "./aws_cloudfront"
}

module "aws_dynamodb" {
  source = "./aws_dynamodb"
}

module "aws_ebs" {
  source = "./aws_ebs"
}

module "aws_ec2" {
  source = "./aws_ec2"
}

module "aws_ecs" {
  source = "./aws_ecs"
}

module "aws_elasticache" {
  source = "./aws_elasticache"
}

module "aws_elb" {
  source = "./aws_elb"
}

module "aws_kinesis_analytics" {
  source = "./aws_kinesis_analytics"
}

module "aws_kinesis_streams" {
  source = "./aws_kinesis_streams"
}

module "aws_lambda" {
  source = "./aws_lambda"
}

module "aws_opsworks" {
  source = "./aws_opsworks"
}

module "aws_rds" {
  source = "./aws_rds"
}

module "aws_rds_enhanced" {
  source = "./aws_rds_enhanced"
}

module "aws_rds_enhanced_aurora" {
  source = "./aws_rds_enhanced_aurora"
}

module "aws_redshift" {
  source = "./aws_redshift"
}

module "aws_route53" {
  source = "./aws_route53"
}

module "aws_sns" {
  source = "./aws_sns"
}

module "aws_sqs" {
  source = "./aws_sqs"
}
