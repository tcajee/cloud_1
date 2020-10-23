# Used to set default region for all resouces
variable "region" {
  type    = string
  default = "eu-west-2"
# default = "af-south-1"
}

# Used for resouce naming
variable "project_name" {
  type    = string
  default = "cloud1"
}

# Required for S3 bucket for TF state file as S3 bucket names must universally unique
# only lowercase alphanumeric characters and hyphens allowed
variable "rand" {
  type    = string
  default = "838qrrdmy0"
}

# Required 
variable "profile" {
  type    = string
  default = "2auth"
}
