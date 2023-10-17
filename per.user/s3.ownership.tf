
#
## OWNERSHIP CONTROL + PUBLIC BLOCKS
## - BucketOwnerEnforced gives account owner full ownership of all uploaded objects
## - BucketOwnerEnforced and the public access block restrict ownership capabilities of clients
#

resource "aws_s3_bucket_ownership_controls" "config" {
  bucket = aws_s3_bucket.test.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "config" {
  bucket                  = aws_s3_bucket.test.id
  block_public_policy     = true
  block_public_acls       = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

