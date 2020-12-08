# Cloud_1

This repository contains a Terraform configuration to deploy the neceassary cloud infrastrucutre required for the DevOps module at WeThinkCode. The configuration files in the root folder deploy a GKE Public Cluster and a WordPress chart using [Helm](https://helm.sh/).

## Overview

Follow these step to get up and running with GKE and Helm:

1. [Install the necessary tools](#installing-necessary-tools)
1. [Apply the Terraform code](#apply-the-terraform-code)
1. [Verify the Deployed Chart](#verify-the-deployed-chart)
1. [Destroy the Deployed Resources](#destroy-the-deployed-resources)

## Installing necessary tools

In addition to `terraform`, this configuration relies on `gcloud` and `kubectl` and `helm` tools to manage the cluster.

This means that your system needs to be configured to be able to find `terraform`, `gcloud`, `kubectl` and `helm`
client utilities on the system `PATH`. Here are the installation guides for each tool:

1. [`gcloud`](https://cloud.google.com/sdk/gcloud/)
1. [`kubectl`](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
1. [`terraform`](https://learn.hashicorp.com/terraform/getting-started/install.html)
1. [`helm`](https://docs.helm.sh/using_helm/#installing-helm) (Minimum version v3.0)

Make sure the binaries are discoverable in your `PATH` variable. See [this Stack Overflow
post](https://stackoverflow.com/questions/14637979/how-to-permanently-set-path-on-linux-unix) for instructions on
setting up your `PATH` on Unix, and [this
post](https://stackoverflow.com/questions/1618280/where-can-i-set-path-to-make-exe-on-windows) for instructions on
Windows.

## Apply the Terraform Code

Once all the prerequisite tools are installed, you may proceed to deploy the GKE cluster using these steps:

1. Make sure you are in the root of the repository.
1. Fill in the required variables in `variables.tf`.
1. Authenticate to GCP:
   - `gcloud auth login`
   - `gcloud auth application-default login`
1. Initialize terraform:
   - `terraform init`
1. Check the terraform plan:
   - `terraform plan`
1. Apply the terraform code:
   - `terraform apply`


## Verify the Deployed Chart

At the end of the `terraform apply`, you should now have a working GKE cluster and `kubectl` context configured.
The deployment configures your `kubectl` context, so you can use `kubectl` and `helm` commands without further configuration.

To see the created resources, run the following commands:

```bash
❯ kubectl get deployments -n default
❯ kubectl get service -n default
❯ kubectl get pods -n default
```

If you wish to access the deployed service, you use the `kubectl port-forward` command to forward a local port to the deployed service:

```bash
❯ kubectl port-forward deployment/wordpress 8080:8080 -n default
```

You can now access the deployed service by opening your web browser to `http://localhost:8080`.

## Destroy the deployed resources

To destroy all resources created by the example, just run `terraform destroy`.
