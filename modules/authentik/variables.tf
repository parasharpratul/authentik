variable "db_endpoint" {
  description = "The endpoint for the RDS database"
  type        = string
}

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

variable "authentik_version" {
  description = "The version of Authentik to deploy"
  type        = string
}

variable "availability_zone" {
  description = "The availability zone for the EBS volume"
  type        = string
}
