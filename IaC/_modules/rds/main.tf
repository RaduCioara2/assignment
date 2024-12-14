######################### Terraform Version ##################
locals {
  region1 = "eu-west-1"
  region2 = "eu-central-1"
}

terraform {
  required_version = "1.3.6"

  required_providers {
    aws = "= 5.81.0"
  }
}

provider "aws" {
  region = local.region1
}

provider "aws" {
  alias  = "region2"
  region = local.region2
}