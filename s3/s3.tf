resource "aws_s3_bucket" "adamant-codes" {
  bucket = "adamant-codes"

  tags = {
    Name = "Flugel"
    Owner = "InfraTeam"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.adamant-codes.id
  acl    = "private"
}

output "bucket" {
  value = aws_s3_bucket.adamant-codes.bucket
}

output "bucket-tags" {
    value = aws_s3_bucket.adamant-codes.tags
}