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

variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
}

