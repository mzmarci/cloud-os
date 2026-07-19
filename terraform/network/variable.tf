###################################################
# General Configuration
###################################################

variable "project_name" {
  description = "Name of the project."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

###################################################
# Network Configuration
###################################################

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets."
  type        = list(string)
}

###################################################
# Tags
###################################################

variable "tags" {
  description = "Common tags to apply to resources."
  type        = map(string)

  default = {}
}