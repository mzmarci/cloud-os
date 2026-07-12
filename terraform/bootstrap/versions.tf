# First thing every Terraform project should have

terraform {
  required_version = ">= 1.8.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}




# Reason for using version.tf 

# This ensures:

# Every engineer uses a compatible Terraform version.
# Everyone uses the same AWS provider version.
# Builds remain consistent across machines and CI/CD.