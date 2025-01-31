provider "aws" {
  region = var.aws_region
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = module.eks.cluster_token
  }
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = module.eks.cluster_token
}

module "eks" {
  source = "./modules/eks"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids
}

module "rds" {
  source = "./modules/rds"

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  subnet_ids  = var.subnet_ids
  vpc_id      = var.vpc_id
}

module "authentik" {
  source = "./modules/authentik"

  db_endpoint        = module.rds.db_endpoint
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  authentik_version  = var.authentik_version
  availability_zone  = var.availability_zone
}

resource "kubernetes_storage_class" "gp2" {
  metadata {
    name = "gp2"
    annotations = {
      "storageclass.kubernetes.io/is-default-class" = "true"  # Make it the default StorageClass
    }
  }

  storage_provisioner = "kubernetes.io/aws-ebs"
  reclaim_policy      = "Delete"
  volume_binding_mode = "Immediate"  # Set volumeBindingMode to Immediate
  parameters = {
    type = "gp2"
  }
}

module "backups" {
  source = "./modules/backups"

  ebs_volume_id = module.authentik.ebs_volume_id
  aws_region   = var.aws_region
}
