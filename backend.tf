# Bucket name and DynamoDB Table name should match those defined in remote-state/vars.tf
terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "${var.project_name}${var.rand}"
    dynamodb_table = "${var.project_name}${var.rand}"
    region         = "us-east-1"
    key            = "tf/state"
  }
}
