variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "The Kubernetes version to use for the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the EKS cluster will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "The list of subnet IDs where the EKS cluster will be deployed"
  type        = list(string)
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
