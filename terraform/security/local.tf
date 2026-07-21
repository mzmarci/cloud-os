locals {

  prefix = "${var.project_name}-${var.environment}"

  alb_sg_name = "${local.prefix}-alb-sg"

  app_sg_name = "${local.prefix}-app-sg"

  db_sg_name = "${local.prefix}-db-sg"

}