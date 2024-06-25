provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = {
      "owner"         = "ryan.blignaut@bbd.co.za"
      "created-using" = "terraform"
    }
  }
}