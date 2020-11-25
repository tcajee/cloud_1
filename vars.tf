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
