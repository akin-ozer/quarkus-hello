provider "aws" {
  region = "eu-west-1"
}
variable "instance_count" {
  default = "2"
}