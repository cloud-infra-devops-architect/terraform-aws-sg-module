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
