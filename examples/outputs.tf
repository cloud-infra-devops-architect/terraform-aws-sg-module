output "self_enabled_security_group_id" {
  description = "Created security group ID for self-reference-enabled example."
  value       = module.app_security_group_self_enabled.security_group_id
}

output "self_enabled_self_reference_rule_id" {
  description = "Self-reference rule ID for self-reference-enabled example."
  value       = module.app_security_group_self_enabled.self_reference_rule_id
}

output "self_disabled_security_group_id" {
  description = "Created security group ID for self-reference-disabled example."
  value       = module.app_security_group_self_disabled.security_group_id
}

output "self_disabled_self_reference_rule_id" {
  description = "Self-reference rule ID for self-reference-disabled example (null)."
  value       = module.app_security_group_self_disabled.self_reference_rule_id
}
