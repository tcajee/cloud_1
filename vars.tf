// Project Name
variable "project_name" {
  type    = string
  default = "cloud-1"
}

// Project ID
variable "project_id" {
  type    = string
  default = "cloud-1-296510"
}

// Region 1
variable "region1" {
  type        = string
  description = "US East Region"
  default     = "us-east1" 
}

// Region 2
variable "region2" {
  type        = string
  description = "US West Region"
  default     = "us-west1"
}

// SQL Database Name
variable "db_name" {
  type        = string
  description = "SQL Database Name"
}

// SQL Database Root Password
variable "db_root_pass" {
  type        = string
  description = "Root Password For SQL Database"
}

// SQL Database Username
variable "db_user" {
  type        = string
  description = "SQL Database Username"
}

// SQL Database Password
variable "db_user_pass" {
  type        = string
  description = "Password for SQL Database"
}
