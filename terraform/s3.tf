resource "aws_s3_bucket" "beanstalk_deployment_bucket" {
  bucket        = "home-loans-service-fe-deployment"
  force_destroy = true
}

resource "aws_s3_bucket" "frontend" {
  bucket        = "home-loans-service-fe-admin-portal"
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "frontend" {
  bucket = aws_s3_bucket.frontend.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_policy" "frontend" {
  bucket = aws_s3_bucket.frontend.id
  policy = jsonencode({
    "Version" : "2008-10-17",
    "Id" : "PolicyForCloudFrontPrivateContent",
    "Statement" : [
      {
        "Sid" : "AllowCloudFrontServicePrincipal",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "cloudfront.amazonaws.com"
        },
        "Action" : [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        "Resource" : [
          "${aws_s3_bucket.frontend.arn}/*",
          aws_s3_bucket.frontend.arn
        ],
        "Condition" : {
          "StringEquals" : {
            "AWS:SourceArn" : aws_cloudfront_distribution.frontend.arn
          }
        }
      }
    ]
  })
}