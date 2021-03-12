resource "aws_cloudfront_distribution" "cf_distribution" {
  depends_on = [
      var.dependency_arn
  ]
  
  aliases = var.alias_domain

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.target_id
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "allow-all"
  }

  enabled = true

  origin {
    domain_name = var.target_domain_name
    origin_id   = var.target_id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn = var.certificate_arn
    ssl_support_method = "vip"
  }
}