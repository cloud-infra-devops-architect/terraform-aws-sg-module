variable "aws_region" {
  description = "AWS region where resources will be created."
  type        = string
  default     = "us-east-1"

  validation {
    condition     = length(trimspace(var.aws_region)) > 0
    error_message = "aws_region must not be empty."
  }
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created."
  type        = string

  validation {
    condition     = can(regex("^vpc-[0-9a-f]+$", var.vpc_id))
    error_message = "vpc_id must look like vpc-xxxxxxxx."
  }
}
