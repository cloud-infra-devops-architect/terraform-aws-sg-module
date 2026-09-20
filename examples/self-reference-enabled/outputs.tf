output "security_group_id" {
  description = "Created security group ID."
  value       = module.app_security_group.security_group_id
}

output "self_reference_rule_id" {
  description = "Self-reference rule ID from the module."
  value       = module.app_security_group.self_reference_rule_id
}

