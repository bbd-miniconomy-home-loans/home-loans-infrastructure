terraform {
  backend "s3" {
    bucket         = "434468814231-state"
    key            = "state/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "434468814231-state"
  }
}