# ---------------------------------------------------------------------------------------------------------------------
# PROJECT VARIABLES 
# ---------------------------------------------------------------------------------------------------------------------

variable "project_name" {
  description = "The project name as on GCP."
  type        = string
}

variable "project_id" {
  description = "The project ID where all resources will be launched."
  type        = string
}

variable "location" {
  description = "The location (region or zone) of the GKE cluster."
  type        = string
}

variable "region" {
  description = "The region for the network. If the cluster is regional, this must be the same region. Otherwise, it should be the region of the zone."
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# CLUSTER VARIABLES 
# ---------------------------------------------------------------------------------------------------------------------

variable "kubernetes_version" {
  description = "The Kubernetes version of the masters. If set to 'latest' it will pull latest available version in the selected region."
  type        = string
  default     = "latest"
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster."
  type        = string
  default     = "gke-private-cluster"
}

variable "cluster_description" {
  description = "The description of the cluster"
  type        = string
  default     = ""
}

# variable "cluster_secondary_range_name" {
#   description = "The name of the secondary range within the subnetwork for the cluster to use"
#   type        = string
# }

variable "cluster_resource_labels" {
  description = "The GCE resource labels (a map of key/value pairs) to be applied to the cluster."
  type        = map
  default     = {}
}

variable "http_load_balancing" {
  description = "Whether to enable the http (L7) load balancing addon"
  type        = bool
  default     = true
}

variable "horizontal_pod_autoscaling" {
  description = "Whether to enable the horizontal pod autoscaling addon"
  type        = bool
  default     = true
}

variable "enable_private_nodes" {
  description = "Control whether nodes have internal IP addresses only. If enabled, all nodes are given only RFC 1918 private addresses and communicate with the master via private networking."
  type        = bool
  default     = true
}

variable "disable_public_endpoint" { # <------------------------- CHECK THIS
  # In production, it highly recommend restricting access to only within the network boundary, requiring your users to use a bastion host or VPN.
  description = "Control whether the master's internal IP address is used as the cluster endpoint. If set to 'true', the master can only be accessed from internal IP addresses."
  type        = bool
  default     = true
}


# ---------------------------------------------------------------------------------------------------------------------
# NETWORK VARIABLES 
# ---------------------------------------------------------------------------------------------------------------------

# variable "network" {
#   description = "A reference (self_link) to the VPC network to apply firewall rules to"
#   type        = string
# }

# variable "subnetwork" {
#   description = "A reference (self link) to the subnetwork to host the cluster in"
#   type        = string
# }

# variable "public_subnetwork" {
#   description = "A reference (self_link) to the public subnetwork of the network"
#   type        = string
# }

# variable "private_subnetwork" {
#   description = "A reference (self_link) to the private subnetwork of the network"
#   type        = string
# }

variable allowed_public_restricted_subnetworks { # <-------------- CHECK THIS
  description = "The public networks that is allowed access to the public_restricted subnetwork of the network"
  type        = list(string)
  default     = []
}

variable "master_authorized_networks_config" {
  description = <<EOF
  The desired configuration options for master authorized networks.
  Omit the nested cidr_blocks attribute to disallow external access (except the cluster node IPs, which GKE automatically whitelists)
  ### example format ###
  master_authorized_networks_config = [{
    cidr_blocks = [{
      cidr_block   = "10.0.0.0/8"
      display_name = "example_network"
    }],
  }]
EOF
  type        = list(any)
  default     = []
}

# variable "network_project" {
#   description = "The project ID of the shared VPC's host (for shared vpc support)"
#   type        = string
#   default     = ""
# }


# ---------------------------------------------------------------------------------------------------------------------
# CIDR VARIABLES 
# ---------------------------------------------------------------------------------------------------------------------

variable "master_ipv4_cidr_block" {  #< ----------------------_CHECK THIS
  description = "The IP range in CIDR notation (size must be /28) to use for the hosted master network. This range will be used for assigning internal IP addresses to the master or set of masters, as well as the ILB VIP. This range must not overlap with any other ranges in use within the cluster's network."
  type        = string
  default     = "10.5.0.0/28"
#   default     = ""
}


variable "cidr_block" {
  description = "The IP address range of the VPC in CIDR notation. A prefix of /16 is recommended. Do not use a prefix higher than /27."
  default     = "10.0.0.0/16"
  type        = string
}

variable "cidr_subnetwork_width_delta" {
  description = "The difference between your network and subnetwork netmask; an /16 network and a /20 subnetwork would be 4."
  type        = number
  default     = 4
}

variable "cidr_subnetwork_spacing" {
  description = "How many subnetwork-mask sized spaces to leave between each subnetwork type."
  type        = number
  default     = 0
}

variable "secondary_cidr_block" {
  description = "The IP address range of the VPC's secondary address range in CIDR notation. A prefix of /16 is recommended. Do not use a prefix higher than /27."
  type        = string
  default     = "10.1.0.0/16"
}

variable "secondary_cidr_subnetwork_width_delta" {
  description = "The difference between your network and subnetwork's secondary range netmask; an /16 network and a /20 subnetwork would be 4."
  type        = number
  default     = 4
}

variable "secondary_cidr_subnetwork_spacing" {
  description = "How many subnetwork-mask sized spaces to leave between each subnetwork type's secondary ranges."
  type        = number
  default     = 0
}

# variable "non_masquerade_cidrs" {
#   description = "List of strings in CIDR notation that specify the IP address ranges that do not use IP masquerading."
#   type        = list(string)
#   default     = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
# }

# # See https://cloud.google.com/kubernetes-engine/docs/concepts/verticalpodautoscaler
# variable "enable_vertical_pod_autoscaling" {
#   description = "Whether to enable Vertical Pod Autoscaling"
#   type        = string
#   default     = false
# }

# variable "logging_service" {
#   description = "The logging service that the cluster should write logs to. Available options include logging.googleapis.com/kubernetes, logging.googleapis.com (legacy), and none"
#   type        = string
#   default     = "logging.googleapis.com/kubernetes"
# }

# variable "monitoring_service" {
#   description = "The monitoring service that the cluster should write metrics to. Automatically send metrics from pods in the cluster to the Stackdriver Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting. Available options include monitoring.googleapis.com/kubernetes, monitoring.googleapis.com (legacy), and none"
#   type        = string
#   default     = "monitoring.googleapis.com/kubernetes"
# }

# variable "maintenance_start_time" {
#   description = "Time window specified for daily maintenance operations in RFC3339 format"
#   type        = string
#   default     = "05:00"
# }

# variable "stub_domains" {
#   description = "Map of stub domains and their resolvers to forward DNS queries for a certain domain to an external DNS server"
#   type        = map(string)
#   default     = {}
# }

# variable "ip_masq_resync_interval" {
#   description = "The interval at which the agent attempts to sync its ConfigMap file from the disk."
#   type        = string
#   default     = "60s"
# }

# variable "ip_masq_link_local" {
#   description = "Whether to masquerade traffic to the link-local prefix (169.254.0.0/16)."
#   type        = bool
#   default     = false
# }

# variable "enable_legacy_abac" {
#   description = "Whether to enable legacy Attribute-Based Access Control (ABAC). RBAC has significant security advantages over ABAC."
#   type        = bool
#   default     = false
# }

# variable "enable_network_policy" {
#   description = "Whether to enable Kubernetes NetworkPolicy on the master, which is required to be enabled to be used on Nodes."
#   type        = bool
#   default     = true
#  }

# variable "basic_auth_username" {
#   description = "The username used for basic auth; set both this and `basic_auth_password` to \"\" to disable basic auth."
#   type        = string
#   default     = ""
# }

# variable "basic_auth_password" {
#   description = "The password used for basic auth; set both this and `basic_auth_username` to \"\" to disable basic auth."
#   type        = string
#   default     = ""
# }

# variable "enable_client_certificate_authentication" {
#   description = "Whether to enable authentication by x509 certificates. With ABAC disabled, these certificates are effectively useless."
#   type        = bool
#   default     = false
# }

# # See https://cloud.google.com/kubernetes-engine/docs/how-to/role-based-access-control#google-groups-for-gke
# variable "gsuite_domain_name" {
#   description = "The domain name for use with Google security groups in Kubernetes RBAC. If a value is provided, the cluster will be initialized with security group `gke-security-groups@[yourdomain.com]`."
#   type        = string
#   default     = null
# }

# variable "secrets_encryption_kms_key" {
#   description = "The Cloud KMS key to use for the encryption of secrets in etcd, e.g: projects/my-project/locations/global/keyRings/my-ring/cryptoKeys/my-key"
#   type        = string
#   efault     = null
# }

# variable "services_secondary_range_name" {
#   description = "The name of the secondary range within the subnetwork for the services to use"
#   type        = string
#   default     = null
# }

# variable "log_config" {
#   description = "The logging options for the subnetwork flow logs. Setting this value to `null` will disable them. See https://www.terraform.io/docs/providers/google/r/compute_subnetwork.html for more information and examples."
#   type = object({
#     aggregation_interval = string
#     flow_sampling        = number
#     metadata             = string
#   })

#   default = {
#     aggregation_interval = "INTERVAL_10_MIN"
#     flow_sampling        = 0.5
#     metadata             = "INCLUDE_ALL_METADATA"
#   }
# }

# ---------------------------------------------------------------------------------------------------------------------
# SERVICE ACCOUNT VARIABLES 
# ---------------------------------------------------------------------------------------------------------------------

# variable "service_account_name" {
#   description = "The name of the custom service account used for the GKE cluster. This parameter is limited to a maximum of 28 characters."
#   type        = string
#   default     = "gke-private-cluster-sa"
# }

# variable "service_account_description" {
#   description = "A description of the custom service account used for the GKE cluster."
#   type        = string
#   default     = "Custom GKE Cluster Service Account managed by Terraform"
# }

# variable "service_account_roles" {
#   description = "Additional roles to be added to the service account."
#   type        = list(string)
#   default     = []
# }

# variable "alternative_default_service_account" {
#   description = "Alternative Service Account to be used by the Node VMs. If not specified, the default compute Service Account will be used. Provide if the default Service Account is no longer available."
#   type        = string
#   default     = null
# }