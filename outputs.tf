output "cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = module.eks.cluster_endpoint
}

output "db_endpoint" {
  description = "The endpoint for the RDS database"
  value       = module.rds.db_endpoint
}

output "authentik_url" {
  description = "The URL for the Authentik application"
  value       = module.authentik.authentik_url
}

output "ebs_volume_id" {
  description = "The ID of the EBS volume used for Authentik data"
  value       = module.authentik.ebs_volume_id
}
