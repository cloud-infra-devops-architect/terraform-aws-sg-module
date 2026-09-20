# Amazon Q Rules for Terraform AWS Security Group Module

These rules define module standards for `terraform-aws-sg-module`.

## Purpose

- Keep the module reusable as a child module.
- Enforce secure defaults and explicit rule definitions.
- Keep docs and module structure consistent.

## File Structure

Required files:

- `main.tf`
- `variables.tf`
- `outputs.tf`
- `versions.tf`
- `README.md`
- `examples/README.md`
- `examples/self-reference-enabled/main.tf`
- `examples/self-reference-disabled/main.tf`

## Security

- The module must support both IPv4 and IPv6 security group rules.
- Self-referencing rule must be controlled by a boolean toggle (`enable_self_reference`).
- Avoid broad internet exposure where possible:
  - No ingress rule should allow all protocols (`-1`) from `0.0.0.0/0`.
  - No ingress rule should allow all protocols (`-1`) from `::/0`.
- Reusable module pattern is allowed for SG attachment:
  - `CKV2_AWS_5` may be skipped because attachments are made in consumer modules/resources.

## Variable Definitions

- Every variable must include:
  - `description`
  - `type`
- Variables should use `validation` blocks where constraints are meaningful (CIDR, ports, protocols, booleans, enums).

## Outputs

- Every output must include a `description`.
- Output names should be explicit and snake_case.

## Examples

- Must include both:
  - self-reference enabled usage
  - self-reference disabled usage
- Example code should use module source relative path and include required inputs.

## What To Avoid

- Hardcoded secrets, credentials, or keys.
- VPC-module-only rules and checks (for example `map_public_ip_on_launch`, `flow_logs.tf`, or EIP `domain` checks), since they are not applicable to security group modules.

