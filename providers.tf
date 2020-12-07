# ---------------------------------------------------------------------------------------------------------------------
# CONFIGURE PROVIDERS
# ---------------------------------------------------------------------------------------------------------------------

provider "google" {
  project = var.project_id
  region  = var.region
  credentials = file("./terraform-gcp-credentials.json")
}

provider "kubernetes" {}

