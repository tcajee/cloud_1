// Google Cloud provider
provider "google" {
  project     = var.project_id
  credentials = file("./terraform-gcp-credentials.json")
}

// Kubernetes Provider
provider "kubernetes" {}
