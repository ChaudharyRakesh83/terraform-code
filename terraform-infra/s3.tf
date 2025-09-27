resource "aws_s3_bucket" "s3-bucket" {
  bucket = "terraform-bucket-rakesh123"
  acl    = "private"

}
