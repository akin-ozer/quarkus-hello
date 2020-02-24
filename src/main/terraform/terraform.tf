terraform {
  backend "s3" {
    bucket = "akinozer-terraform-backend"
    key = "terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "terraform-state-lock"
  }
}
