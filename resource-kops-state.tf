resource "aws_s3_bucket" "kops_state" {
  bucket        = var.kops_state_bucket_name

  tags = {
    Name    = "S3 Bucket for KOps State"
    Project = "Task 3"
  }
}

resource "aws_s3_bucket_ownership_controls" "kops_owner" {
  bucket = aws_s3_bucket.kops_state.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "kops_access" {
  bucket = aws_s3_bucket.kops_state.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "kops_acl" {
  bucket = aws_s3_bucket.kops_state.id
  acl    = "public-read"
  depends_on = [aws_s3_bucket_ownership_controls.kops_owner]
}

resource "aws_s3_bucket_versioning" "versioning_enable" {
  bucket = aws_s3_bucket.kops_state.id

  versioning_configuration {
    status = "Enabled"
  }
}
