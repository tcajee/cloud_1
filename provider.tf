// Google Cloud provider
provider "google" {
  project     = var.project_id
  credentials = file("./terraform-gcp-credentials.json")
}

// Kubernetes Provider
provider "kubernetes" {} // <----- Configure k8?

// helm
// helm pull chartrepo/chartname (for values.yml from bitnami/wordpress)
