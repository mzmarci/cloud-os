locals {

  ###################################################
  # Naming Convention
  ###################################################

  prefix = "${var.project_name}-${var.environment}"

  terraform_state_bucket = "${local.prefix}-terraform-state"

  terraform_lock_table = "${local.prefix}-terraform-locks"

  ###################################################
  # Standard Tags
  ###################################################

  common_tags = {

    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = var.owner

  }

}