resource "aws_s3_bucket" "bucket" {
  bucket = "slinkistaskbucketlambda"

  tags = {
    Name        = "slinkistestbucket"
    Environment = "Dev"
    acl = "private"
  }
}

