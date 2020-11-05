# Used to set default region for all resouces
variable "region" {
  type    = string
  default = "us-east-1"
}

# Used for resouce naming
variable "project_name" {
  type    = string
  default = "cloud"
}

# Required for S3 bucket for TF state file as S3 bucket names must universally unique
# only lowercase alphanumeric characters and hyphens allowed
variable "rand" {
  type    = string
  default = "afo8957uy"
}

# Required 
variable "profile" {
  type    = string
  default = "mfa"
}
