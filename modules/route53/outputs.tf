output "zone_id" {
  description = "The ID of the created Route 53 zone."
  value       = aws_route53_zone.zone.id
}