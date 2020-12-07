# ---------------------------------------------------------------------------------------------------------------------
# OUTPUTS
# ---------------------------------------------------------------------------------------------------------------------

output "cluster_name" {
  # This may seem redundant with the `name` input, but it serves an important
  # purpose. Terraform won't establish a dependency graph without this to interpolate on.
  description = "The name of the cluster master. This output is used for interpolation with node pools, other modules."

  value = google_container_cluster.cluster.name
}

output "cluster_endpoint" {
  description = "The IP address of the cluster master."
  sensitive   = true
  value       = google_container_cluster.cluster.endpoint
}

# The following three outputs allow authentication and connectivity to the GKE Cluster.
output "client_certificate" {
  description = "Public certificate used by clients to authenticate to the cluster endpoint."
  value       = base64decode(google_container_cluster.cluster.master_auth[0].client_certificate)
}

output "client_key" {
  description = "Private key used by clients to authenticate to the cluster endpoint."
  value       = base64decode(google_container_cluster.cluster.master_auth[0].client_key)
}

output "cluster_ca_certificate" {
  description = "The public certificate that is the root of trust for the cluster."
  value       = base64decode(google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
}

# output "service_account_email" {
#   # This may seem redundant with the `name` input, but it serves an important
#   # purpose. Terraform won't establish a dependency graph without this to interpolate on.
#   description = "The email address of the custom service account."
#   value       = google_service_account.service_account.email
# }

output "master_version" {
  description = "The Kubernetes master version."
  value       = google_container_cluster.cluster.master_version
}

# output "network" {
#   description = "A reference (self_link) to the VPC network"
#   value       = google_compute_network.vpc.self_link
# }

# ---------------------------------------------------------------------------------------------------------------------
# Public Subnetwork Outputs
# ---------------------------------------------------------------------------------------------------------------------

output "public_subnetwork" {
  description = "A reference (self_link) to the public subnetwork"
  value       = google_compute_subnetwork.vpc_subnetwork_public.self_link
}

output "public_subnetwork_name" {
  description = "Name of the public subnetwork"
  value       = google_compute_subnetwork.vpc_subnetwork_public.name
}

output "public_subnetwork_cidr_block" {
  value = google_compute_subnetwork.vpc_subnetwork_public.ip_cidr_range
}

output "public_subnetwork_gateway" {
  value = google_compute_subnetwork.vpc_subnetwork_public.gateway_address
}

# output "public_subnetwork_secondary_cidr_block" {
#   value = google_compute_subnetwork.vpc_subnetwork_public.secondary_ip_range[0].ip_cidr_range
# }

# output "public_subnetwork_secondary_range_name" {
#   value = google_compute_subnetwork.vpc_subnetwork_public.secondary_ip_range[0].range_name
# }

# ---------------------------------------------------------------------------------------------------------------------
# Private Subnetwork Outputs
# ---------------------------------------------------------------------------------------------------------------------

output "private_subnetwork" {
  description = "A reference (self_link) to the private subnetwork"
  value       = google_compute_subnetwork.vpc_subnetwork_private.self_link
}

output "private_subnetwork_name" {
  description = "Name of the private subnetwork"
  value       = google_compute_subnetwork.vpc_subnetwork_private.name
}

output "private_subnetwork_cidr_block" {
  value = google_compute_subnetwork.vpc_subnetwork_private.ip_cidr_range
}

output "private_subnetwork_gateway" {
  value = google_compute_subnetwork.vpc_subnetwork_private.gateway_address
}

# output "private_subnetwork_secondary_cidr_block" {
#   value = google_compute_subnetwork.vpc_subnetwork_private.secondary_ip_range[0].ip_cidr_range
# }

# output "private_subnetwork_secondary_range_name" {
#   value = google_compute_subnetwork.vpc_subnetwork_private.secondary_ip_range[0].range_name
# }

# output "public" {
#   description = "The string of the public tag"
#   value       = local.public
# }

# output "public_restricted" {
#   description = "The string of the public tag"
#   value       = local.public_restricted
# }

# output "private" {
#   description = "The string of the private tag"
#   value       = local.private
# }

# output "private_persistence" {
#   description = "The string of the private-persistence tag"
#   value       = local.private_persistence
# }
