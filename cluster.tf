// Create container cluster
resource "google_container_cluster" "gke_cluster" {
  name                     = "gke-cluster"
  description              = "Cloud-1 GKE Cluster"
  project                  = var.project_id
  location                 = var.region1
  network                  = google_compute_network.wp_vpc.name
  subnetwork               = google_compute_subnetwork.wp_subnet.name
  remove_default_node_pool = true
  initial_node_count       = 1

  depends_on = [
    google_compute_subnetwork.wp_subnet
  ]
}

// Create node pool for container cluster
resource "google_container_node_pool" "gke_node_pool" {
  name       = "gke-nodepool"
  project    = var.project_id
  location   = var.region1
  cluster    = google_container_cluster.gke_cluster.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-micro"
  }

  autoscaling {
    min_node_count = 2
    max_node_count = 5
  }

  depends_on = [
    google_container_cluster.gke_cluster
  ]
}
