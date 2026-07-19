###################################################
# Available Availability Zones
###################################################

data "aws_availability_zones" "available" {

  state = "available"

}

###################################################
# Current AWS Region
###################################################

data "aws_region" "current" {}

###################################################
# AWS Account Information
###################################################

data "aws_caller_identity" "current" {}