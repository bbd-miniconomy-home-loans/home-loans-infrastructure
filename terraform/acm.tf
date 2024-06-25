resource "aws_acm_certificate" "https_frontend_cert" {
  domain_name       = local.domain_name
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "https_api_cert" {
  domain_name       = "api.${local.domain_name}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}