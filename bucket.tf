resource "aws_s3_bucket" "source" {
  bucket        = "${var.bucket_artifact_store}"
  acl           = "private"
  force_destroy = true
}