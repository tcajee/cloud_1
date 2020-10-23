# Private Bastion SG

resource "aws_security_group" "bastion" {
  name        = "bation"
  description = "Public Bation"
  vpc_id      = aws_vpc.main.id

  tags = merge(
    {
      resouce_type = "security"
      Name         = "bastion"
    },
    local.common_tags
  )
}

resource "aws_security_group_rule" "bastion_ingress_ssh" {
  type              = "ingress"
  from_port         = 0
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = local.allowed_remote_ssh_ip_list
  security_group_id = aws_security_group.bastion.id
}

# Private Load Balancer SG

resource "aws_security_group" "load_balancer" {
  name        = "load_balancer"
  description = "Public Load Balancer"
  vpc_id      = aws_vpc.main.id

  tags = merge(
    {
      resouce_type = "security"
      Name         = "load_balancer"
    },
    local.common_tags
  )
}

resource "aws_security_group_rule" "load_balancer_ingress_http" {
  type      = "ingress"
  from_port = 0
  to_port   = 80
  protocol  = "all"
  cidr_blocks = [
    local.anywhere_cidr
  ]
  security_group_id = aws_security_group.load_balancer.id
}

resource "aws_security_group_rule" "load_balancer_ingress_https" {
  type      = "ingress"
  from_port = 0
  to_port   = 443
  protocol  = "all"
  cidr_blocks = [
    local.anywhere_cidr
  ]
  security_group_id = aws_security_group.load_balancer.id
}

# Private Web SG

resource "aws_security_group" "web" {
  name        = "web"
  description = "Private Web"
  vpc_id      = aws_vpc.main.id

  tags = merge(
    {
      resouce_type = "security"
      Name         = "web"
    },
    local.common_tags
  )
}

resource "aws_security_group_rule" "web_ingress_ssh" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion.id
  security_group_id        = aws_security_group.web.id
}

resource "aws_security_group_rule" "web_ingress_http" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 80
  protocol                 = "all"
  source_security_group_id = aws_security_group.load_balancer.id
  security_group_id        = aws_security_group.load_balancer.id
}

resource "aws_security_group_rule" "web_ingress_https" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 443
  protocol                 = "all"
  source_security_group_id = aws_security_group.load_balancer.id
  security_group_id        = aws_security_group.load_balancer.id
}

# Private Database SG

resource "aws_security_group" "database" {
  name        = "database"
  description = "Private Database"
  vpc_id      = aws_vpc.main.id

  tags = merge(
    {
      resouce_type = "security"
      Name         = "database"
    },
    local.common_tags
  )
}

resource "aws_security_group_rule" "database_ingress_mysql" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web.id
  security_group_id        = aws_security_group.database.id
}
