terraform {
  required_version = ">= 0.12.20, < 0.14"

  required_providers {
    aws = ">= 2.51, < 4.0"
  }

  backend "s3" {
    bucket = "tf-bucket-lab"
    region = "eu-west-3"
    key = "tf/tf-lab.tfstate"
#    dynamodb_table = "terraform-state-lock-dynamo"
    encrypt = true
  }

}

provider "aws" {
  region      = var.aws_region
}
