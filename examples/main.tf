provider "aws" {
  region = var.aws_region
}

module "app_security_group_self_enabled" {
  source = "../"

  name        = "example-app-sg-self-enabled"
  description = "Example SG with self-referencing rule enabled"
  vpc_id      = var.vpc_id

  ingress_ipv4_rules = [
    {
      description = "Allow HTTPS from internet"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
  ]

  ingress_ipv6_rules = [
    {
      description = "Allow HTTPS from IPv6 internet"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_ipv6   = "::/0"
    }
  ]

  egress_ipv4_rules = [
    {
      description = "Allow all outbound IPv4"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  ]

  egress_ipv6_rules = [
    {
      description = "Allow all outbound IPv6"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_ipv6   = "::/0"
    }
  ]

  enable_self_reference      = true
  self_reference_type        = "ingress"
  self_reference_protocol    = "tcp"
  self_reference_from_port   = 0
  self_reference_to_port     = 65535
  self_reference_description = "Allow intra-SG workload traffic"

  tags = {
    Name        = "example-app-sg-self-enabled"
    Environment = "dev"
    Example     = "self-reference-enabled"
  }
}

module "app_security_group_self_disabled" {
  source = "../"

  name        = "example-app-sg-self-disabled"
  description = "Example SG with self-referencing rule disabled"
  vpc_id      = var.vpc_id

  ingress_ipv4_rules = [
    {
      description = "Allow HTTP from corporate IPv4"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_ipv4   = "10.0.0.0/8"
    },
    {
      description = "Allow HTTPS from corporate IPv4"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_ipv4   = "10.0.0.0/8"
    }
  ]

  ingress_ipv6_rules = [
    {
      description = "Allow HTTPS from trusted IPv6 range"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_ipv6   = "2001:db8::/32"
    }
  ]

  egress_ipv4_rules = [
    {
      description = "Allow all outbound IPv4"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  ]

  egress_ipv6_rules = [
    {
      description = "Allow all outbound IPv6"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_ipv6   = "::/0"
    }
  ]

  enable_self_reference = false

  tags = {
    Name        = "example-app-sg-self-disabled"
    Environment = "dev"
    Example     = "self-reference-disabled"
  }
}
