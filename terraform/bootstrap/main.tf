###################################################
# Terraform State Bucket
###################################################

resource "aws_s3_bucket" "terraform_state" {

  bucket = local.terraform_state_bucket

  tags = merge(
    local.common_tags,
    {
      Name = local.terraform_state_bucket
    }
  )

}


###################################################
# Enable Versioning
###################################################

resource "aws_s3_bucket_versioning" "terraform_state" {

  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {

    status = "Enabled"

  }

}

###################################################
# Bucket Encryption
###################################################

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {

  bucket = aws_s3_bucket.terraform_state.id

  rule {

    apply_server_side_encryption_by_default {

      sse_algorithm = "AES256"

    }

  }

}

###################################################
# Block Public Access
###################################################

resource "aws_s3_bucket_public_access_block" "terraform_state" {

  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls = true

  block_public_policy = true

  ignore_public_acls = true

  restrict_public_buckets = true

}


###################################################
# Terraform Lock Table
###################################################

resource "aws_dynamodb_table" "terraform_lock" {

  name = local.terraform_lock_table

  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

  attribute {

    name = "LockID"

    type = "S"

  }

  tags = merge(

    local.common_tags,

    {

      Name = local.terraform_lock_table

    }

  )

}