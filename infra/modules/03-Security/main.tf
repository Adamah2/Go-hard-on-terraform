# Jump Server Security Group - Only SSH from your IP
resource "aws_security_group" "jump_server_sg" {
  name        = "${local.prefix}-jump"
  description = "Jump security group"
  vpc_id      = var.vpc_id

  tags = merge(local.tags, {
    Name = "${local.prefix}-jump-server"
  })
}

# Allow SSH from your IP to Jump Server
resource "aws_security_group_rule" "jump_server_sg_ssh_rule" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.jump_server_sg.id
  cidr_blocks       = [local.myIp.cidr_block]
}

# ALB Security Group - HTTP/HTTPS from Internet + SSH from Jump
resource "aws_security_group" "alb_sg" {
  name        = "${local.prefix}-alb"
  description = "ALB security group"
  vpc_id      = var.vpc_id

  tags = merge(local.tags, {
    Name = "${local.prefix}-alb"
  })
}

# Allow HTTP from Internet to ALB
resource "aws_security_group_rule" "alb_sg_http_rule" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks       = [local.everyWhere.cidr_block]
}

# Allow HTTPS from Internet to ALB
resource "aws_security_group_rule" "alb_sg_https_rule" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks       = [local.everyWhere.cidr_block]
}

# Allow SSH from Jump Server to ALB
resource "aws_security_group_rule" "alb_sg_ssh_rule" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.alb_sg.id
  source_security_group_id = aws_security_group.jump_server_sg.id
}

# ECS Security Group - HTTP/HTTPS from ALB + SSH from Jump
resource "aws_security_group" "ecs_sg" {
  name        = "${local.prefix}-ecs"
  description = "ECS security group"
  vpc_id      = var.vpc_id

  tags = merge(local.tags, {
    Name = "${local.prefix}-ecs"
  })
}

# Allow HTTP from ALB to ECS
resource "aws_security_group_rule" "ecs_sg_http_rule" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ecs_sg.id
  source_security_group_id = aws_security_group.alb_sg.id
}

# Allow HTTPS from ALB to ECS
resource "aws_security_group_rule" "ecs_sg_https_rule" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ecs_sg.id
  source_security_group_id = aws_security_group.alb_sg.id
}

# Allow SSH from Jump Server to ECS
resource "aws_security_group_rule" "ecs_sg_ssh_rule" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ecs_sg.id
  source_security_group_id = aws_security_group.jump_server_sg.id
}

# RDS Security Group - DB traffic from ECS + SSH from Jump
resource "aws_security_group" "rds_sg" {
  name        = "${local.prefix}-rds"
  description = "RDS security group"
  vpc_id      = var.vpc_id

  tags = merge(local.tags, {
    Name = "${local.prefix}-rds"
  })
}

# Allow SSH from Jump Server to RDS
resource "aws_security_group_rule" "rds_sg_ssh_rule" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = aws_security_group.jump_server_sg.id
}

# Allow DB traffic from ECS to RDS (port depends on engine)
resource "aws_security_group_rule" "rds_sg_db_rule" {
  type                     = "ingress"
  from_port                = var.rds_engine == "mysql" ? 3306 : var.rds_engine == "postgres" ? 5432 : 0
  to_port                  = var.rds_engine == "mysql" ? 3306 : var.rds_engine == "postgres" ? 5432 : 0
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = aws_security_group.ecs_sg.id
}
