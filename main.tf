terraform {
  # Use the latest and greatest Terraform version, 0.14.0, released December 02, 2020.
  # See CHANGELOG [here](https://github.com/hashicorp/terraform/blob/v0.14.0/CHANGELOG.md)
  #  required_version = ">= 0.14.0"
  required_version = ">= 0.12.26"
 }

resource "null_resource" "set_gcloud_project" {
  # Set Current Project in gcloud SDK
  provisioner "local-exec" {
    command = "gcloud config set project ${var.project_id}"
  }
}

resource "null_resource" "configure_kubectl" {
  # Configure Kubectl with GCP K8s Cluster
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${google_container_cluster.cluster.name} --region ${google_container_cluster.cluster.location} --project ${google_container_cluster.cluster.project}"
  }

  depends_on = [ 
    null_resource.set_gcloud_project,
    google_container_cluster.cluster
  ]
}

resource "null_resource" "helm_deployment" {
  # Set Current Project in gcloud SDK
  provisioner "local-exec" {
    command = "helm repo add bitnami https://charts.bitnami.com/bitnami && helm install my-release bitnami/wordpress"
  }

  depends_on = [ 
    null_resource.configure_kubectl
  ]
}
