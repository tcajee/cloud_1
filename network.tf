# ---------------------------------------------------------------------------------------------------------------------
# Create the Network & corresponding Router to attach other resources to
# Networks that preserve the default route are automatically enabled for Private Google Access to GCP services
# provided subnetworks each opt-in; in general, Private Google Access should be the default.
# ---------------------------------------------------------------------------------------------------------------------

# Use a random suffix to prevent overlap in network names
# resource "random_string" "suffix" {
#   length  = 4
#   special = false
#   upper   = false
# }

resource "google_compute_network" "vpc" {
  name    = "vpc-network"
  project = var.project_id

  # Always define custom subnetworks- one subnetwork per region isn't useful for an opinionated setup
  auto_create_subnetworks = "false"

  # A global routing mode can have an unexpected impact on load balancers; always use a regional mode
  routing_mode = "REGIONAL"
}

resource "google_compute_router" "vpc_router" {
  name = "vpc-router"
  project = var.project_id
  region  = var.region
  network = google_compute_network.vpc.self_link
}


# ---------------------------------------------------------------------------------------------------------------------
# Private Subnetwork Config
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_subnetwork" "vpc_subnetwork_private" {
  name = "vpc-subnetwork-private"
  project = var.project_id
  region  = var.region
  network = google_compute_network.vpc.self_link

  private_ip_google_access = true

  ip_cidr_range = cidrsubnet(
    var.cidr_block,
    var.cidr_subnetwork_width_delta, # <----------------- CHECK THIS
    1 * (1 + var.cidr_subnetwork_spacing) # <----------------- CHECK THIS
  )

  # secondary_ip_range {
  #   range_name = "private-services"
  #   ip_cidr_range = cidrsubnet(
  #     var.secondary_cidr_block,
  #     var.secondary_cidr_subnetwork_width_delta,
  #     1 * (1 + var.secondary_cidr_subnetwork_spacing)
  #   )
  # }

  # dynamic "log_config" {
  #   for_each = var.log_config == null ? [] : list(var.log_config)

  #   content {
  #     aggregation_interval = var.log_config.aggregation_interval
  #     flow_sampling        = var.log_config.flow_sampling
  #     metadata             = var.log_config.metadata
  #   }
  # }

}

# ---------------------------------------------------------------------------------------------------------------------
# Public Subnetwork Config
# Public internet access for instances with addresses is automatically configured by the default gateway for 0.0.0.0/0
# External access is configured with Cloud NAT, which subsumes egress traffic for instances without external addresses
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_subnetwork" "vpc_subnetwork_public" {
  name = "vpc-subnetwork-public"

  project = var.project_id
  region  = var.region
  network = google_compute_network.vpc.self_link

  private_ip_google_access = true

  ip_cidr_range            = cidrsubnet(var.cidr_block, var.cidr_subnetwork_width_delta, 0) # <----------------- CHECK THIS

  # secondary_ip_range {
  #   range_name = "public-services"
  #   ip_cidr_range = cidrsubnet(
  #     var.secondary_cidr_block,
  #     var.secondary_cidr_subnetwork_width_delta,
  #     0
  #   )
  # }

  # dynamic "log_config" {
  #   for_each = var.log_config == null ? [] : list(var.log_config)

  #   content {
  #     aggregation_interval = var.log_config.aggregation_interval
  #     flow_sampling        = var.log_config.flow_sampling
  #     metadata             = var.log_config.metadata
  #   }
  # }

}

resource "google_compute_router_nat" "vpc_nat" {

  name = "vpc-nat"
  project = var.project_id
  region  = var.region
  router  = google_compute_router.vpc_router.name

  nat_ip_allocate_option = "AUTO_ONLY"

  # "Manually" define the subnetworks for which the NAT is used, so that we can exclude the public subnetwork
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.vpc_subnetwork_public.self_link
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A NETWORK TO DEPLOY THE CLUSTER TO
# ---------------------------------------------------------------------------------------------------------------------

# module "vpc_network" {
#   source = "github.com/gruntwork-io/terraform-google-network.git//modules/vpc-network?ref=v0.6.0"

  # name_prefix = "${var.cluster_name}-network-${random_string.suffix.result}"
  # project     = var.project
  # region      = var.region

#   cidr_block           = var.vpc_cidr_block
#   secondary_cidr_block = var.vpc_secondary_cidr_block
# }