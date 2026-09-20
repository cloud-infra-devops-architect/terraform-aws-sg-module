resource "aws_security_group" "this" {
  name                   = var.name
  description            = var.description
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = var.revoke_rules_on_delete

  tags = var.tags
}

locals {
  ingress_ipv4_rules = {
    for index, rule in var.ingress_ipv4_rules : index => rule
  }

  ingress_ipv6_rules = {
    for index, rule in var.ingress_ipv6_rules : index => rule
  }

  egress_ipv4_rules = {
    for index, rule in var.egress_ipv4_rules : index => rule
  }

  egress_ipv6_rules = {
    for index, rule in var.egress_ipv6_rules : index => rule
  }
}

resource "aws_security_group_rule" "ingress_ipv4" {
  for_each = local.ingress_ipv4_rules

  type              = "ingress"
  security_group_id = aws_security_group.this.id
  description       = each.value.description
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = [each.value.cidr_ipv4]
}

resource "aws_security_group_rule" "ingress_ipv6" {
  for_each = local.ingress_ipv6_rules

  type              = "ingress"
  security_group_id = aws_security_group.this.id
  description       = each.value.description
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  ipv6_cidr_blocks  = [each.value.cidr_ipv6]
}

resource "aws_security_group_rule" "egress_ipv4" {
  for_each = local.egress_ipv4_rules

  type              = "egress"
  security_group_id = aws_security_group.this.id
  description       = each.value.description
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = [each.value.cidr_ipv4]
}

resource "aws_security_group_rule" "egress_ipv6" {
  for_each = local.egress_ipv6_rules

  type              = "egress"
  security_group_id = aws_security_group.this.id
  description       = each.value.description
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  ipv6_cidr_blocks  = [each.value.cidr_ipv6]
}

resource "aws_security_group_rule" "self_reference" {
  count = var.enable_self_reference ? 1 : 0

  type              = lower(var.self_reference_type)
  security_group_id = aws_security_group.this.id
  description       = var.self_reference_description
  from_port         = var.self_reference_from_port
  to_port           = var.self_reference_to_port
  protocol          = var.self_reference_protocol
  self              = true
}

