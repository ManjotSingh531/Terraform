terraform {
  backend "s3" {
    bucket = "gibs"
    key = "development/terraform_state"
    region = "ap-south-1"
  }
}