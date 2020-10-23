# creates an S3 bucket to store the state file in
resource "aws_s3_bucket" "tf_state" {
  bucket = "${var.project_name}${var.rand}"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = merge(
    {
      resouce_type = "terraform_infra"
    },
    local.common_tags
  )
}
