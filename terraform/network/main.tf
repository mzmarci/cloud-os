###################################################
# Virtual Private Cloud (VPC)
#
# This VPC provides the isolated networking
# environment for the Puter platform.
#
# It is designed to support:
#
# - EKS
# - NAT Gateway
# - Public Subnets
# - Private Subnets
# - Load Balancers
# - Future Platform Services
###################################################




###################################################
# Virtual Private Cloud (VPC)
###################################################

resource "aws_vpc" "main" {

  cidr_block = var.vpc_cidr

  enable_dns_support = true

  enable_dns_hostnames = true

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-vpc"
    }
  )

}



###################################################
# Public Subnets
###################################################

resource "aws_subnet" "public" {

  count = length(local.public_subnet_cidrs)

  vpc_id = aws_vpc.main.id

  cidr_block = element(
    local.public_subnet_cidrs,
    count.index
  )

  availability_zone = element(
    data.aws_availability_zones.available.names,
    count.index
  )

  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "${local.prefix}-public-${count.index + 1}"

      "kubernetes.io/role/elb" = "1"
    }
  )

}

###################################################
# Internet Gateway
###################################################

resource "aws_internet_gateway" "main" {

  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = "${local.prefix}-igw"
    }
  )

}