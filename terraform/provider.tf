terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.39.1"
    }
  }
}

provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      "owner"         = "ryan.blignaut@bbd.co.za"
      "created-using" = "terraform"
    }
  }
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"

  default_tags {
    tags = {
      "owner"         = "ryan.blignaut@bbd.co.za"
      "created-using" = "terraform"
    }
  }
}