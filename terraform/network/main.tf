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
# Private Subnets
###################################################

resource "aws_subnet" "private" {

  count = length(local.private_subnet_cidrs)

  vpc_id = aws_vpc.main.id

  cidr_block = element(
    local.private_subnet_cidrs,
    count.index
  )

  availability_zone = element(
    data.aws_availability_zones.available.names,
    count.index
  )

  map_public_ip_on_launch = false

  tags = merge(
    var.tags,
    {
      Name = "${local.prefix}-private-${count.index + 1}"

      "kubernetes.io/role/internal-elb" = "1"
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



###################################################
# Public Route Table
###################################################

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.main.id

  }

  tags = merge(
    var.tags,
    {
      Name = "${local.prefix}-public-rt"
    }
  )

}

###################################################
# Public Route Table Association
###################################################

resource "aws_route_table_association" "public" {

  count = length(aws_subnet.public)

  subnet_id = aws_subnet.public[count.index].id

  route_table_id = aws_route_table.public.id

}

###################################################
# Elastic IP for NAT Gateway
###################################################

resource "aws_eip" "nat" {

  domain = "vpc"

  tags = merge(
    var.tags,
    {
      Name = local.nat_eip_name
    }
  )

}

###################################################
# NAT Gateway
###################################################

resource "aws_nat_gateway" "main" {

  allocation_id = aws_eip.nat.id

  subnet_id = aws_subnet.public[0].id

  tags = merge(
    var.tags,
    {
      Name = local.nat_gateway_name
    }
  )

  depends_on = [
    aws_internet_gateway.main
  ]

}

###################################################
# Private Route Table
###################################################

resource "aws_route_table" "private" {

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.main.id

  }

  tags = merge(
    var.tags,
    {
      Name = local.private_route_table_name
    }
  )

}

###################################################
# Private Route Table Association
###################################################

resource "aws_route_table_association" "private" {

  count = length(aws_subnet.private)

  subnet_id = aws_subnet.private[count.index].id

  route_table_id = aws_route_table.private.id

}
