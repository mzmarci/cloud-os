terraform {

  backend "s3" {

    bucket = "puter-dev-terraform-state"

    key = "bootstrap/terraform.tfstate"

    region = "eu-west-1"

    dynamodb_table = "puter-dev-terraform-locks"

    encrypt = true

  }

}