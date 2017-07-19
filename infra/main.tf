variable "app_name" {
  default = "my-app"
}

variable "profile" {
  default = "default"
}

provider "aws" {
  region = "us-east-1"
  profile = "${var.profile}"
}

output "bucket_name" {
  value = "${aws_s3_bucket.main.id}"
}

output "cloudfront_id" {
  value = "${aws_cloudfront_distribution.main.id}"
}

output "cloudfront_domain" {
  value = "${aws_cloudfront_distribution.main.domain_name}"
}
