# Bucket name and DynamoDB Table name should match those defined in remote-state/vars.tf
terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "cloud1838qrrdmy0"
    dynamodb_table = "cloud1838qrrdmy0"
    region         = "eu-west-2"
    key            = "tf/state"
  }
}