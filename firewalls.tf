# ---------------------------------------------------------------------------------------------------------------------
# Attach Firewall Rules to allow inbound traffic to tagged instances
# ---------------------------------------------------------------------------------------------------------------------

# module "network_firewall" {
#   source = "../network-firewall"

#   name_prefix = var.name_prefix

#   project                               = var.project
#   network                               = google_compute_network.vpc.self_link
#   allowed_public_restricted_subnetworks = var.allowed_public_restricted_subnetworks

#   public_subnetwork  = google_compute_subnetwork.vpc_subnetwork_public.self_link
#   private_subnetwork = google_compute_subnetwork.vpc_subnetwork_private.self_link
# }

# data "google_compute_subnetwork" "public_subnetwork" {
#   self_link = google_compute_subnetwork.vpc_subnetwork_public.self_link
#  }

# data "google_compute_subnetwork" "private_subnetwork" {
#   self_link = google_compute_subnetwork.vpc_subnetwork_private.self_link
# }

# ---------------------------------------------------------------------------------------------------------------------
# public - allow ingress from anywhere
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_firewall" "public_allow_all_inbound" {

  name = "firewall-public-allow-ingress"
  project = var.project_id
  network = google_compute_network.vpc.self_link

  direction     = "INGRESS"
  target_tags   = [local.public]
  source_ranges = ["0.0.0.0/0"]

  priority = "1000"

  allow {
    protocol = "all"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# public - allow ingress from specific sources
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_firewall" "public_restricted_allow_inbound" {

  count = length(var.allowed_public_restricted_subnetworks) > 0 ? 1 : 0

  name = "firewall-public-restricted-allow-ingress"
  project = var.project_id
  network = google_compute_network.vpc.self_link

  direction     = "INGRESS"
  target_tags   = [local.public_restricted]
  source_ranges = var.allowed_public_restricted_subnetworks

  priority = "1000"

  allow {
    protocol = "all"
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# private - allow ingress from within this network
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_firewall" "private_allow_all_network_inbound" {

  name = "firewall-private-allow-ingress"
  project = var.project_id
  network = google_compute_network.vpc.self_link

  target_tags = [local.private]
  direction   = "INGRESS"

  source_ranges = [
    # data.google_compute_subnetwork.public_subnetwork.ip_cidr_range,
    google_compute_subnetwork.vpc_subnetwork_public.ip_cidr_range,
    # data.google_compute_subnetwork.public_subnetwork.secondary_ip_range[0].ip_cidr_range,
    # data.google_compute_subnetwork.private_subnetwork.ip_cidr_range,
    google_compute_subnetwork.vpc_subnetwork_private.ip_cidr_range,
    # data.google_compute_subnetwork.private_subnetwork.secondary_ip_range[0].ip_cidr_range,
  ]

  priority = "1000"

  allow {
    protocol = "all"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# private-persistence - allow ingress from `private` and `private-persistence` instances in this network
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_firewall" "private_allow_restricted_network_inbound" {

  name = "firewall-allow-restricted-inbound"
  project = var.project_id
  network = google_compute_network.vpc.self_link

  direction   = "INGRESS"
  target_tags = [local.private_persistence]

  # source_tags is implicitly within this network; tags are only applied to instances that rest within the same network
  source_tags = [local.private, local.private_persistence]

  priority = "1000"

  allow {
    protocol = "all"
  }
}

