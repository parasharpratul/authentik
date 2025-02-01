resource "aws_db_instance" "authentik_db" {
  identifier           = "authentik-db"
  engine               = "postgres"
  engine_version       = "11.22"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  storage_type         = "gp2"
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.postgres11"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.authentik_db_subnet_group.name

  # Enable automated backups
  backup_retention_period = 7  # Retention period in days (1-35)
  backup_window           = "03:00-04:00"  # Preferred backup window (UTC)
  maintenance_window      = "sun:04:00-sun:05:00"  # Preferred maintenance window (UTC)

  # Enable deletion protection (optional but recommended for production)
  deletion_protection = true
}

resource "aws_db_subnet_group" "authentik_db_subnet_group" {
  name       = "authentik-db-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_security_group" "rds_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
