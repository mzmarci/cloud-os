locals {

  ###################################################
  # Naming Convention
  ###################################################

  prefix = "${var.project_name}-${var.environment}"

  vpc_name = "${local.prefix}-vpc"

  igw_name = "${local.prefix}-igw"

  ###################################################
  # Subnets
  ###################################################

  public_subnet_cidrs = [

    cidrsubnet(var.vpc_cidr, 6, 0),

    cidrsubnet(var.vpc_cidr, 6, 1)

  ]

  private_subnet_cidrs = [

    cidrsubnet(var.vpc_cidr, 6, 2),

    cidrsubnet(var.vpc_cidr, 6, 3)

  ]

}