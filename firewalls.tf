// Create Firewall for WordPress VPC 
resource "google_compute_firewall" "wp_firewall" {
  name    = "wp-firewall"
  network = google_compute_network.wp_vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }

  source_tags = ["wp", "wordpress"]

  depends_on = [
    google_compute_network.wp_vpc
  ]
}


// Create Firewall for Database VPC 
resource "google_compute_firewall" "db_firewall" {
  name    = "db-firewall"
  network = google_compute_network.db_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "3306"]
  }

  source_tags = ["db", "database"]

  depends_on = [
    google_compute_network.db_vpc
  ]
}
