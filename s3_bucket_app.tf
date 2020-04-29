# Create S3 bucket to store the application deployment files ##

resource "aws_s3_bucket" "eb-bucket" {
  bucket = "elasticbeanstalk-${var.aws_region}-${var.aws_account_id}"
#  bucket_prefix = "elasticbeanstalk-${var.aws_region}-${var.app_name}"
#  region = var.aws_region
  acl    = "private"
  tags = {
    Name  = "eb-bucket"
  }
  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_object" "eb-bucket-object" {
  bucket = aws_s3_bucket.eb-bucket.id
#  bucket = "elasticbeanstalk-${var.aws_region}-${var.aws_account_id}"
  key    = "EB-${var.app_name}-appcode/sample.war"
  source = "./sample.war"
}

