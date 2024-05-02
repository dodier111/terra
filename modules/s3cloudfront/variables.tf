variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "certificate_arn" {
  description = "ARN of ACM certificate for HTTPS"
  type        = string
}

variable "distribution_name" {
  description = "Name for the CloudFront distribution"
  type        = string
}
