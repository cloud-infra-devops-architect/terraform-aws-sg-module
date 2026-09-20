# Examples for `terraform-aws-sg-module` 🧩

This folder contains runnable examples showing how to consume the child module for:
- ✅ Self-referencing rule enabled
- ✅ Self-referencing rule disabled

## Example Structure

- `main.tf` → contains both example module calls
- `variables.tf` → shared inputs for both examples
- `outputs.tf` → outputs for both examples
- `versions.tf` → provider and Terraform version constraints

## Architecture Diagrams

### 1) Self-Referencing Disabled 🚫🔁

```mermaid
flowchart LR
    IPv4["🌐 IPv4 Sources"]
    IPv6["🌍 IPv6 Sources"]
    SG["🛡️ AWS Security Group\n(Amazon VPC)"]
    EC2["🖥️ Amazon EC2"]
    Outbound["📤 Internet / AWS Services"]

    IPv4 -->|Ingress IPv4 Rules| SG
    IPv6 -->|Ingress IPv6 Rules| SG
    SG --> EC2
    EC2 -->|Egress IPv4 + IPv6 Rules| Outbound
```

### 2) Self-Referencing Enabled ✅🔁

```mermaid
flowchart LR
    Nodes["🖥️ EC2 Nodes in same SG"]
    SG["🛡️ AWS Security Group\n(Amazon VPC)"]
    VPC["📦 Amazon VPC"]

    Nodes --> SG
    SG -->|Self-Reference Rule| SG
    SG --> VPC
```

## How to Run

### Run Consolidated Examples

```bash
cd examples
terraform init
terraform plan -var='vpc_id=vpc-1234abcd'
terraform apply -var='vpc_id=vpc-1234abcd'
```

## Mandatory Inputs

These inputs are required by the consolidated examples.

| Name | Type | Description |
|------|------|-------------|
| `vpc_id` | `string` | VPC ID where the security group will be created. |

## Optional Inputs

These optional inputs are available for the consolidated examples.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `aws_region` | `string` | `"us-east-1"` | AWS region for provider configuration. |

## Outputs

The consolidated examples return the following outputs.

| Name | Description |
|------|-------------|
| `self_enabled_security_group_id` | ID of security group from self-reference-enabled example. |
| `self_enabled_self_reference_rule_id` | Self-reference rule ID from self-reference-enabled example. |
| `self_disabled_security_group_id` | ID of security group from self-reference-disabled example. |
| `self_disabled_self_reference_rule_id` | Self-reference rule ID from self-reference-disabled example (`null`). |

## Child Module Inputs Summary

The child module at `../` supports:
- IPv4 and IPv6 ingress/egress rule objects
- Optional self-referencing rule with `enable_self_reference`
- Validated rule protocol, port ranges, and CIDR formats

For the complete list, see the root module docs in `README.md`.
