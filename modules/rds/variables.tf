variable "db_name" {
  description = "The name of the RDS database"
  type        = string
}

variable "db_username" {
  description = "The username for the RDS database"
  type        = string
}

variable "db_password" {
  description = "The password for the RDS database"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "The VPC ID where the RDS instance will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "The list of subnet IDs where the RDS instance will be deployed"
  type        = list(string)
}
