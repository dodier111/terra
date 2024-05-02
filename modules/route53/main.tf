provider "aws" {
  region = var.region
}

resource "aws_route53_zone" "zone" {
  name = var.domain_name
}

