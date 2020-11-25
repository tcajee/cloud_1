// Project ID
variable "project_id" {
  type    = string
  default = "cloud-1-296510"
}

// Region 1 
variable "region1" {
  type        = string
  description = "Region 1"
  default     = "europe-west2" // <-- Change this
}

// Region 2
variable "region2" {
  type        = string
  description = "Region 2"
  default     = "asia-south1" // <-- Change this
}

// SQL Database Root Password
variable "root_pass" {
  type        = string
  description = "Root Password For SQL Database"
  default     = "toor" // <-- Change this
}

// SQL Database Name
variable "database" {
  type        = string
  description = "SQL Database Name"
  default     = "wpdb"
}

// SQL Database Username
variable "db_user" {
  type        = string
  description = "SQL Database Username"
  default     = "wpuser"
}

// SQL Database Password
variable "db_user_pass" {
  type        = string
  description = "Password for SQL Database"
  default     = "wppass" // <-- Change this
}
