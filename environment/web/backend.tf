terraform {
  required_version = ">= 0.12.20, < 0.14"

  required_providers {
    aws = ">= 2.51, < 4.0"
  }

  backend "s3" {
    bucket = "tf-bucket-lab"
    region = "eu-west-3"
    key = "tf-lab.tfstate"
#    dynamodb_table = "terraform-state-lock-dynamo"
    encrypt = true
  }

}

provider "aws" {
  access_key  = var.access_key
  secret_key  = var.secret_key
  region      = var.aws_region
}

resource "aws_s3_bucket" "terraform-state-s3" {
  bucket = "tf-bucket-lab"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }
}
