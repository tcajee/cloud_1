// Set Current Project in gcloud SDK
resource "null_resource" "set_gcloud_project" {
  provisioner "local-exec" {
    command = "gcloud config set project ${var.project_id}"
  }
}

// Configure Kubectl with GCP K8s Cluster
resource "null_resource" "configure_kubectl" {
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${google_container_cluster.gke_cluster.name} --region ${google_container_cluster.gke_cluster.location} --project ${google_container_cluster.gke_cluster.project}"
  }

  depends_on = [
    null_resource.set_gcloud_project,
    google_container_cluster.gke_cluster
  ]
}

// WordPress Deployment
resource "kubernetes_deployment" "wp_dep" {
  metadata {
    name = "wp-dep"
    labels = {
      env = "Production"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        pod = "wp"
        env = "Production"
      }
    }

    template {
      metadata {
        labels = {
          pod = "wp"
          env = "Production"
        }
      }

      spec {
        container {
          image = "wordpress"
          name  = "wp_container"

          env {
            name  = "WORDPRESS_DB_HOST"
            value = google_sql_database_instance.mysql.ip_address.0.ip_address
          }
          env {
            name  = "WORDPRESS_DB_USER"
            value = var.db_user
          }
          env {
            name  = "WORDPRESS_DB_PASSWORD"
            value = var.db_user_pass
          }
          env {
            name  = "WORDPRESS_DB_NAME"
            value = var.database
          }
          env {
            name  = "WORDPRESS_TABLE_PREFIX"
            value = "wp_"
          }

          port {
            container_port = 80
          }
        }
      }
    }
  }

  depends_on = [
    null_resource.set_gcloud_project,
    null_resource.configure_kubectl,
    google_container_cluster.gke_cluster,
    google_container_node_pool.gke_node_pool
  ]
}
