// Create Firewall for WordPress VPC 
resource "google_compute_firewall" "wp_firewall" {
  name    = "wp-firewall"
  network = google_compute_network.wp_vpc.name

  allow {
    protocol = "icmp"
  }

  //  
  allow {
    protocol = "tcp"
    ports    = ["80", "8080"] // <---------------------------- Check this 
  }

  # source_tags = ["wp", "wordpress"] <--------------- check this 

  depends_on = [
    google_compute_network.wp_vpc
  ]
}
