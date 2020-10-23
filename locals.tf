locals {
  # example common tags which should be applied to all resources for cost tracking ect.
  common_tags = {
    project_name = var.project_name
    cost_centre  = "cld1"
  }
}