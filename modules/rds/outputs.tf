output "db_endpoint" {
  description = "The endpoint for the RDS database"
  value       = aws_db_instance.authentik_db.endpoint
}
