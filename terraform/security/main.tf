###################################################
# Application Load Balancer Security Group
###################################################

resource "aws_security_group" "alb" {

  name = local.alb_sg_name

  description = "Security Group for the Application Load Balancer"

  vpc_id = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = local.alb_sg_name
    }
  )

}

###################################################
# Allow HTTP
###################################################

resource "aws_vpc_security_group_ingress_rule" "alb_http" {

  security_group_id = aws_security_group.alb.id

  description = "Allow HTTP"

  cidr_ipv4 = "0.0.0.0/0"

  from_port = 80

  to_port = 80

  ip_protocol = "tcp"

}

resource "aws_vpc_security_group_ingress_rule" "alb_https" {

  security_group_id = aws_security_group.alb.id

  description = "Allow HTTPS"

  cidr_ipv4 = "0.0.0.0/0"

  from_port = 443

  to_port = 443

  ip_protocol = "tcp"

}

resource "aws_vpc_security_group_egress_rule" "alb" {

  security_group_id = aws_security_group.alb.id

  description = "Allow outbound traffic"

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"

}

###################################################
# Application Security Group
###################################################

resource "aws_security_group" "app" {

  name        = local.app_sg_name

  description = "Security Group for the Puter application"

  vpc_id = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = local.app_sg_name
    }
  )

}

###################################################
# Allow ALB to reach Puter
###################################################

resource "aws_vpc_security_group_ingress_rule" "app_http" {

  security_group_id = aws_security_group.app.id

  referenced_security_group_id = aws_security_group.alb.id

  description = "Allow traffic from the ALB"

  from_port = 4100

  to_port = 4100

  ip_protocol = "tcp"

}

###################################################
# Application Egress
###################################################

resource "aws_vpc_security_group_egress_rule" "app" {

  security_group_id = aws_security_group.app.id

  description = "Allow outbound traffic"

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"

}

###################################################
# Database Security Group
###################################################

resource "aws_security_group" "db" {

  name        = local.db_sg_name
  description = "Security Group for the MariaDB database"

  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = local.db_sg_name
    }
  )
}

###################################################
# Allow MariaDB from the Application
###################################################

resource "aws_vpc_security_group_ingress_rule" "db_mysql" {

  security_group_id = aws_security_group.db.id

  referenced_security_group_id = aws_security_group.app.id

  description = "Allow MariaDB traffic from the application"

  from_port = 3306

  to_port   = 3306

  ip_protocol = "tcp"
}

