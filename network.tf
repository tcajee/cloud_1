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
  ip_cidr_range = "10.2.0.0/16" // <--------------------------------- Check this
  project       = var.project_id
  region        = var.region1
  network       = google_compute_network.wp_vpc.id

  depends_on = [
    google_compute_network.wp_vpc
  ]
}

// Create Database VPC
resource "google_compute_network" "db_vpc" {
  name                    = "prod-db-env"
  description             = "VPC network for database"
  project                 = var.project_id
  auto_create_subnetworks = false
}

// Creating Database Subnet
resource "google_compute_subnetwork" "db_subnet" {
  name          = "db-subnet"
  ip_cidr_range = "10.4.0.0/16" // <------------------------------------- Check this
  project       = var.project_id
  region        = var.region2
  network       = google_compute_network.db_vpc.id

  depends_on = [
    google_compute_network.db_vpc
  ]
}

// Create WordPress to Database peering
resource "google_compute_network_peering" "wp_peer_db" {
  name         = "wp-peer-db"
  network      = google_compute_network.wp_vpc.id
  peer_network = google_compute_network.db_vpc.id

  depends_on = [
    google_compute_network.wp_vpc,
    google_compute_network.db_vpc
  ]
}

// Create Database to WordPress peering
resource "google_compute_network_peering" "db_peer_wp" {
  name         = "db-peer-wp"
  network      = google_compute_network.db_vpc.id
  peer_network = google_compute_network.wp_vpc.id

  depends_on = [
    google_compute_network.wp_vpc,
    google_compute_network.db_vpc 
  ]
}
