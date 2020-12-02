// Create WordPress VPC
resource "google_compute_network" "wp_vpc" {
  name                    = "prod-wp-env"
  description             = "VPC Network for WordPress"
  project                 = var.project_id
  auto_create_subnetworks = false
}

// Create WordPress Subnet
resource "google_compute_subnetwork" "wp_subnet" {
  name          = "wp-subnet"
  ip_cidr_range = local.subnets.main.public.cidr
  project       = var.project_id
  region        = var.region
  network       = google_compute_network.wp_vpc.id

  depends_on = [
    google_compute_network.wp_vpc
  ]
}
