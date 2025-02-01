output "backup_vault_name" {
  description = "The name of the backup vault"
  value       = aws_backup_vault.authentik_backup_vault.name
}

output "backup_plan_name" {
  description = "The name of the backup plan"
  value       = aws_backup_plan.authentik_backup_plan.name
}
