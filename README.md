# Cloud_1

This repository contains a Terraform configuration to deploy the neceassary cloud infrastrucutre required for the DevOps module at WeThinkCode.

## Pre-requisites

- Install [`terraform`](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- Install [`gcloud SDK`](https://cloud.google.com/sdk/docs/install)
- Install [`kubectl`](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- Install [`Helm`](https://helm.sh/)


## Configuration

- Replace the terraform-gcp-credentials.json file with your service account key file
- Update the project ID in vars.tf

## Terraform
-To Initiate Terraform workSpace: `terraform init`
-To create infrastructure: `terraform apply -auto-approve`
-To delete infrastructure: `terraform destroy -auto-approve`


### Troubleshooting
#### Kubectl
Verifying kubectl configuration
In order for kubectl to find and access a Kubernetes cluster, it needs a kubeconfig file, which is created automatically when you create a cluster using kube-up.sh or successfully deploy a Minikube cluster. By default, kubectl configuration is located at ~/.kube/config.

Check that kubectl is properly configured by getting the cluster state:

kubectl cluster-info

If you see a URL response, kubectl is correctly configured to access your cluster.

If you see a message similar to the following, kubectl is not configured correctly or is not able to connect to a Kubernetes cluster.

The connection to the server <server-name:port> was refused - did you specify the right host or port?

For example, if you are intending to run a Kubernetes cluster on your laptop (locally), you will need a tool like Minikube to be installed first and then re-run the commands stated above.

If kubectl cluster-info returns the url response but you can't access your cluster, to check whether it is configured properly, use:

kubectl cluster-info dump

#### Helm
Helm is a package maneger for kubernetes that we use to install Wordpress on our kubernetes kluster. It also configures the load-balencer and auto-scaler that will be used in the project.

### Notes

run gcloud auth login

