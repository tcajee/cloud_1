# AWS CLI

## Install AWS CLI:

```
pip3 install awscli
```

## Confugure AWS CLI

First set up an IAM user within the AWS Console and create an `"access key"` for cli access to AWS which you will need for the following command.
Also note your desired default region (probably `af-south-1`) and the output format `json`. I would also advise adding 2FA to the IAM using using the console
to ensure your account is kept secure.

You should also update `remote-state/vars.tf` and `vars.tf` with the region which you have selected in the previous step.

```
aws configure
```

## 2FA

If you are using 2FA on your IAM User (recommended) there is a helper script `aws_2fa.sh` which can be used to fetch temporary access tokens and creates a profile called `2auth` which can then be used Terraform.

This script requires that the following environment variables are defined, this can be done either using a .envrc file or by setting them manually.

```
ARN='<MFA_ARN>'
AWS_USER_PROFILE='default'
AWS_PROFILE='2auth'
```

```
./aws_2fa.sh <2FA_CODE>
```

If you're not using 2FA then update the `profile` variable value in `vars.tf` and `remote-state/vars.tf` and set it to `default`

## Install Terraform:

(OSX with HomeBrew)

```
brew install terraform
```

(OSX manual)

```
wget https://releases.hashicorp.com/terraform/0.13.4/terraform_0.13.4_darwin_amd64.zip
unzip terraform_0.13.4_darwin_amd64.zip
rm terraform_0.13.4_darwin_amd64.zip
sudo mv terraform /usr/local/bin/terraform
```

(Ubuntu)

```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
```

## Initialise and Create Terraform Remote State:

Within `remote-state`there is a Terraform definition for an S3 Bucket and a DynamoDB table which are used for Terraform
state storage and stack locking. These must be defined within another directory as a remote backend cannot refer to a S3
Bucket which does not already exist so it's simpler to keep it seperate.

You should ensure that the resouce names within `remote-state/bucket.tf` and `remote-state/dynamodb.tf`, which are
defined using variables defined in `remote-state/vars.tf`, match the values within `backend.tf`. The `rand` value is 
used to ensure the S3 Bucket name is not aleady taken as S3 Bucket names must be unique.

```
cd remote-state
terraform init
terraform apply
```
