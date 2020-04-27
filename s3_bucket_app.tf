# Create S3 bucket to store the application deployment files ##

resource "aws_s3_bucket" "eb-bucket" {
  #bucket = "eb-app-bucket"
  bucket_prefix = "elasticbeanstalk-${var.aws_region}-${var.app_name}"
  region = var.aws_region
  acl    = "private"
  tags = {
    Name  = "eb-app-bucket"
  }
  versioning {
    enabled = true
  }

}
resource "aws_s3_bucket_object" "eb-bucket-object" {
  bucket = aws_s3_bucket.eb-bucket.id
  key    = "sample.war"
  source = "./sample.war"
  #kms_key_id = var.kms_key_id
}
