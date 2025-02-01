output "authentik_url" {
  description = "The URL for the Authentik application"
  value       = "http://${helm_release.authentik.name}.${helm_release.authentik.namespace}.svc.cluster.local"
}

output "ebs_volume_id" {
  description = "The ID of the EBS volume used for Authentik data"
  value       = aws_ebs_volume.authentik_data.id
}
