data "aws_caller_identity" "current" {}

resource "aws_backup_vault" "authentik_backup_vault" {
  name = "authentik-backup-vault"
}

# AWS Backup Plan
resource "aws_backup_plan" "authentik_backup_plan" {
  name = "authentik-backup-plan"

  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.authentik_backup_vault.name
    schedule          = "cron(0 5 * * ? *)"  # Daily at 5:00 AM UTC

    lifecycle {
      delete_after = 30  # Retain backups for 30 days
    }

    recovery_point_tags = {
      Environment = "production"
    }
  }
}

# AWS Backup Selection
resource "aws_backup_selection" "authentik_backup_selection" {
  name         = "authentik-backup-selection"
  plan_id      = aws_backup_plan.authentik_backup_plan.id
  iam_role_arn = aws_iam_role.authentik_backup_role.arn

  resources = [
    "arn:aws:ec2:${var.aws_region}:${data.aws_caller_identity.current.account_id}:volume/${var.ebs_volume_id}"
  ]
}

# IAM Role for AWS Backup
resource "aws_iam_role" "authentik_backup_role" {
  name = "authentik-backup-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "backup.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "authentik_backup_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AWSBackupFullAccess"
  role       = aws_iam_role.authentik_backup_role.name
}
