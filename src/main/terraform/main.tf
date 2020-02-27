variable "region" {
  default = "eu-west-1"
}

data "aws_caller_identity" "current" {}

provider "aws" {
  region = var.region
}
variable "instance_count" {
  default = "2"
}