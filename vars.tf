# Used to set default region for all resouces
variable "region" {
  type    = string
  default = "us-east-1"
}

# Used for resource naming
variable "project_name" {
  type    = string
  default = "cloud"
}

# Required for S3 bucket for TF state file as S3 bucket names must universally unique.
variable "rand" {
  type    = string
  default = "afo8957uy"
}

# Required for IAM with MFA
variable "profile" {
  type    = string
  default = "mfa"
}
