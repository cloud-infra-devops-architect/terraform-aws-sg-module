variable "name" {
  description = "Name of the security group."
  type        = string

  validation {
    condition     = length(trimspace(var.name)) > 0
    error_message = "The name must not be empty."
  }
}

variable "description" {
  description = "Description of the security group."
  type        = string
  default     = "Managed by Terraform"

  validation {
    condition     = length(trimspace(var.description)) > 0
    error_message = "The description must not be empty."
  }
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created."
  type        = string

  validation {
    condition     = can(regex("^vpc-[0-9a-f]+$", var.vpc_id))
    error_message = "The vpc_id must look like an AWS VPC ID (for example: vpc-1234abcd)."
  }
}

variable "revoke_rules_on_delete" {
  description = "Whether to revoke all attached security group rules before deleting the SG."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to the security group."
  type        = map(string)
  default     = {}
}

variable "ingress_ipv4_rules" {
  description = "IPv4 ingress rules."
  type = list(object({
    description = optional(string, "")
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_ipv4   = string
  }))
  default = []

  validation {
    condition = alltrue([
      for rule in var.ingress_ipv4_rules : can(cidrhost(rule.cidr_ipv4, 0))
    ])
    error_message = "Each ingress IPv4 rule must contain a valid IPv4 CIDR in cidr_ipv4."
  }

  validation {
    condition = alltrue([
      for rule in var.ingress_ipv4_rules : can(regex("^(-1|tcp|udp|icmp|icmpv6|[0-9]+)$", lower(rule.protocol)))
    ])
    error_message = "Each ingress IPv4 rule protocol must be one of -1, tcp, udp, icmp, icmpv6, or a protocol number."
  }

  validation {
    condition = alltrue([
      for rule in var.ingress_ipv4_rules : lower(rule.protocol) == "-1" ? (rule.from_port == 0 && rule.to_port == 0) : (
        rule.from_port >= 0 &&
        rule.to_port >= 0 &&
        rule.from_port <= 65535 &&
        rule.to_port <= 65535 &&
        rule.from_port <= rule.to_port
      )
    ])
    error_message = "Each ingress IPv4 rule must use valid ports; for protocol -1, from_port and to_port must both be 0."
  }
}

variable "ingress_ipv6_rules" {
  description = "IPv6 ingress rules."
  type = list(object({
    description = optional(string, "")
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_ipv6   = string
  }))
  default = []

  validation {
    condition = alltrue([
      for rule in var.ingress_ipv6_rules : can(cidrhost(rule.cidr_ipv6, 0))
    ])
    error_message = "Each ingress IPv6 rule must contain a valid IPv6 CIDR in cidr_ipv6."
  }

  validation {
    condition = alltrue([
      for rule in var.ingress_ipv6_rules : can(regex("^(-1|tcp|udp|icmp|icmpv6|[0-9]+)$", lower(rule.protocol)))
    ])
    error_message = "Each ingress IPv6 rule protocol must be one of -1, tcp, udp, icmp, icmpv6, or a protocol number."
  }

  validation {
    condition = alltrue([
      for rule in var.ingress_ipv6_rules : lower(rule.protocol) == "-1" ? (rule.from_port == 0 && rule.to_port == 0) : (
        rule.from_port >= 0 &&
        rule.to_port >= 0 &&
        rule.from_port <= 65535 &&
        rule.to_port <= 65535 &&
        rule.from_port <= rule.to_port
      )
    ])
    error_message = "Each ingress IPv6 rule must use valid ports; for protocol -1, from_port and to_port must both be 0."
  }
}

variable "egress_ipv4_rules" {
  description = "IPv4 egress rules."
  type = list(object({
    description = optional(string, "")
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_ipv4   = string
  }))
  default = []

  validation {
    condition = alltrue([
      for rule in var.egress_ipv4_rules : can(cidrhost(rule.cidr_ipv4, 0))
    ])
    error_message = "Each egress IPv4 rule must contain a valid IPv4 CIDR in cidr_ipv4."
  }

  validation {
    condition = alltrue([
      for rule in var.egress_ipv4_rules : can(regex("^(-1|tcp|udp|icmp|icmpv6|[0-9]+)$", lower(rule.protocol)))
    ])
    error_message = "Each egress IPv4 rule protocol must be one of -1, tcp, udp, icmp, icmpv6, or a protocol number."
  }

  validation {
    condition = alltrue([
      for rule in var.egress_ipv4_rules : lower(rule.protocol) == "-1" ? (rule.from_port == 0 && rule.to_port == 0) : (
        rule.from_port >= 0 &&
        rule.to_port >= 0 &&
        rule.from_port <= 65535 &&
        rule.to_port <= 65535 &&
        rule.from_port <= rule.to_port
      )
    ])
    error_message = "Each egress IPv4 rule must use valid ports; for protocol -1, from_port and to_port must both be 0."
  }
}

variable "egress_ipv6_rules" {
  description = "IPv6 egress rules."
  type = list(object({
    description = optional(string, "")
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_ipv6   = string
  }))
  default = []

  validation {
    condition = alltrue([
      for rule in var.egress_ipv6_rules : can(cidrhost(rule.cidr_ipv6, 0))
    ])
    error_message = "Each egress IPv6 rule must contain a valid IPv6 CIDR in cidr_ipv6."
  }

  validation {
    condition = alltrue([
      for rule in var.egress_ipv6_rules : can(regex("^(-1|tcp|udp|icmp|icmpv6|[0-9]+)$", lower(rule.protocol)))
    ])
    error_message = "Each egress IPv6 rule protocol must be one of -1, tcp, udp, icmp, icmpv6, or a protocol number."
  }

  validation {
    condition = alltrue([
      for rule in var.egress_ipv6_rules : lower(rule.protocol) == "-1" ? (rule.from_port == 0 && rule.to_port == 0) : (
        rule.from_port >= 0 &&
        rule.to_port >= 0 &&
        rule.from_port <= 65535 &&
        rule.to_port <= 65535 &&
        rule.from_port <= rule.to_port
      )
    ])
    error_message = "Each egress IPv6 rule must use valid ports; for protocol -1, from_port and to_port must both be 0."
  }
}

variable "enable_self_reference" {
  description = "Whether to create a self-referencing rule on the same security group."
  type        = bool
  default     = false
}

variable "self_reference_type" {
  description = "Type of self-referencing rule: ingress or egress."
  type        = string
  default     = "ingress"

  validation {
    condition     = contains(["ingress", "egress"], lower(var.self_reference_type))
    error_message = "self_reference_type must be either ingress or egress."
  }
}

variable "self_reference_description" {
  description = "Description for the self-referencing rule."
  type        = string
  default     = "Self reference rule"

  validation {
    condition     = length(trimspace(var.self_reference_description)) > 0
    error_message = "self_reference_description must not be empty."
  }
}

variable "self_reference_protocol" {
  description = "Protocol for the self-referencing rule."
  type        = string
  default     = "-1"

  validation {
    condition     = can(regex("^(-1|tcp|udp|icmp|icmpv6|[0-9]+)$", lower(var.self_reference_protocol)))
    error_message = "self_reference_protocol must be one of -1, tcp, udp, icmp, icmpv6, or a protocol number."
  }
}

variable "self_reference_from_port" {
  description = "From port for the self-referencing rule."
  type        = number
  default     = 0

  validation {
    condition     = var.self_reference_from_port >= 0 && var.self_reference_from_port <= 65535
    error_message = "self_reference_from_port must be between 0 and 65535."
  }
}

variable "self_reference_to_port" {
  description = "To port for the self-referencing rule."
  type        = number
  default     = 0

  validation {
    condition = (
      var.self_reference_to_port >= 0 &&
      var.self_reference_to_port <= 65535 &&
      (
        lower(var.self_reference_protocol) == "-1" ? (
          var.self_reference_from_port == 0 && var.self_reference_to_port == 0
          ) : (
          var.self_reference_from_port <= var.self_reference_to_port
        )
      )
    )
    error_message = "For self-reference, ports must be 0..65535. If protocol is -1 then both ports must be 0; otherwise from_port must be <= to_port."
  }
}
