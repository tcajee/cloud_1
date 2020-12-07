# ---------------------------------------------------------------------------------------------------------------------
# Prepare locals to keep the code cleaner
# ---------------------------------------------------------------------------------------------------------------------

locals {

  latest_version     = data.google_container_engine_versions.location.latest_master_version
  kubernetes_version = var.kubernetes_version != "latest" ? var.kubernetes_version : local.latest_version
  # network_project    = var.network_project != "" ? var.network_project : var.project

  # Define tags as locals so they can be interpolated off of + exported
  public              = "public"
  public_restricted   = "public-restricted"
  private             = "private"
  private_persistence = "private-persistence"


  # all_service_account_roles = concat(var.service_account_roles, [
  #   "roles/logging.logWriter",
  #   "roles/monitoring.metricWriter",
  #   "roles/monitoring.viewer",
  #   "roles/stackdriver.resourceMetadata.writer"
  # ])

}
