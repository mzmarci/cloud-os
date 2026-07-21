###################################################
# Project Name
###################################################

variable "project_name" {

  description = "Project name"

  type = string

}

###################################################
# Environment
###################################################

variable "environment" {

  description = "Deployment environment"

  type = string

}

###################################################
# VPC ID
###################################################

variable "vpc_id" {

  description = "ID of the VPC"

  type = string

}

###################################################
# Common Tags
###################################################

variable "tags" {

  description = "Common resource tags"

  type = map(string)

}