locals {

  ###################################################
  # Naming Convention
  ###################################################

  prefix = "${var.project_name}-${var.environment}"

  vpc_name = "${local.prefix}-vpc"

  igw_name = "${local.prefix}-igw"

  nat_eip_name = "${local.prefix}-nat-eip"

  nat_gateway_name = "${local.prefix}-nat"

  private_route_table_name = "${local.prefix}-private-rt"

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
