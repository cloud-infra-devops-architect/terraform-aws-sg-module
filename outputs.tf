output "security_group_id" {
  description = "ID of the created security group."
  value       = aws_security_group.this.id
}

output "security_group_arn" {
  description = "ARN of the created security group."
  value       = aws_security_group.this.arn
}

output "security_group_name" {
  description = "Name of the created security group."
  value       = aws_security_group.this.name
}

output "security_group_vpc_id" {
  description = "VPC ID where the security group is created."
  value       = aws_security_group.this.vpc_id
}

output "ingress_ipv4_rule_ids" {
  description = "Map of ingress IPv4 rule IDs keyed by rule index."
  value       = { for key, rule in aws_security_group_rule.ingress_ipv4 : key => rule.id }
}

output "ingress_ipv6_rule_ids" {
  description = "Map of ingress IPv6 rule IDs keyed by rule index."
  value       = { for key, rule in aws_security_group_rule.ingress_ipv6 : key => rule.id }
}

output "egress_ipv4_rule_ids" {
  description = "Map of egress IPv4 rule IDs keyed by rule index."
  value       = { for key, rule in aws_security_group_rule.egress_ipv4 : key => rule.id }
}

output "egress_ipv6_rule_ids" {
  description = "Map of egress IPv6 rule IDs keyed by rule index."
  value       = { for key, rule in aws_security_group_rule.egress_ipv6 : key => rule.id }
}

output "self_reference_rule_id" {
  description = "Self-reference rule ID when enabled, otherwise null."
  value       = var.enable_self_reference ? aws_security_group_rule.self_reference[0].id : null
}
