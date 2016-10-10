output "cf_domain_name" {
  value = "${aws_cloudfront_distribution.cf.domain_name}"
}

output "s3_website_endpoint" {
  value = "${aws_s3_bucket.s3.website_endpoint}"
}
