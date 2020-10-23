# create a dynamodb table for locking the state file
resource "aws_dynamodb_table" "tf_state" {
  name           = "${var.project_name}${var.rand}"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = merge(
    {
      resouce_type = "terraform_infra"
    },
    local.common_tags
  )
}
