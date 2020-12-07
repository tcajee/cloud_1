# Cloud_1
This repository contains a Terraform configuration to deploy the neceassary cloud infrastrucutre required for the DevOps module at WeThinkCode.

## Pre-requisites
- Install [`terraform`](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- Install [`gcloud`](https://cloud.google.com/sdk/docs/install)
- Install [`kubectl`](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- Install [`helm`](https://helm.sh/)

## Configuration
- Obtain the terraform-gcp-credentials.json file containing the required service account credentials for the project.

## Terraform
-To initialise Terraform workSpace: `terraform init`
-To create infrastructure: `terraform apply`
-To delete infrastructure: `terraform destroy`

### Helm
Helm is a package maneger for Kubernetes that we use to install WordPress on our Kubernetes cluster using. It also configures the load balancer and auto-scaler that will be used in the project.

## Troubleshooting

### Verifying kubectl configuration

In order for kubectl to find and access a Kubernetes cluster, it needs a kubeconfig file, which is created automatically when you create a cluster using kube-up.sh or successfully deploy a Minikube cluster.

By default, kubectl configuration is located at ~/.kube/config.

-Check that kubectl is properly configured by getting the cluster state:
```bash
kubectl cluster-info
```

If you see a URL response, kubectl is correctly configured to access your cluster.

If you see a message similar to the following, kubectl is not configured correctly or is not able to connect to a Kubernetes cluster.

The connection to the server <server-name:port> was refused - did you specify the right host or port?

If kubectl cluster-info returns the url response but you can't access your cluster, to check whether it is configured properly, use:
```bash
kubectl cluster-info dump
```

### Notes

Gcloud setup:
```bash
gcloud init
gcloud auth login
```

