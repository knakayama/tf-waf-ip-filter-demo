resource "aws_cloudfront_origin_access_identity" "cf" {
  comment = "${var.name}-cf"
}

data "aws_cloudformation_stack" "waf_ip_filter" {
  name = "${var.name}"
}

resource "aws_cloudfront_distribution" "cf" {
  comment             = "${var.name}-cf"
  price_class         = "${var.cf_config["price_class"]}"
  web_acl_id          = "${data.aws_cloudformation_stack.waf_ip_filter.outputs["WebAclId"]}"
  default_root_object = "index.html"
  retain_on_delete    = true
  enabled             = true

  origin {
    domain_name = "${aws_s3_bucket.s3.id}.s3.amazonaws.com"
    origin_id   = "S3-${aws_s3_bucket.s3.id}"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.cf.cloudfront_access_identity_path}"
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "S3-${aws_s3_bucket.s3.id}"
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
