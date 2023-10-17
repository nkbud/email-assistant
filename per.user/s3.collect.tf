
resource "aws_s3_bucket" "invites" {
  bucket = var.name
  tags   = var.tags
}
