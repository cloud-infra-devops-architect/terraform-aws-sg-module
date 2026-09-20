tflint {
  required_version = ">= 0.60.0"
}

plugin "terraform" {
  enabled = false
  version = "0.13.0"
  source  = "github.com/terraform-linters/tflint-ruleset-terraform"
}

plugin "aws" {
  enabled = false
  version = "0.44.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

config {
  force               = false
  call_module_type    = "all"
  disabled_by_default = false
}
