resource "aws_ebs_volume" "authentik_data" {
  availability_zone = var.availability_zone
  size              = 10  # Size in GB
  type              = "gp2"

  tags = {
    Name = "authentik-data-volume"
  }
}

resource "kubernetes_persistent_volume" "authentik_pv" {
  metadata {
    name = "authentik-pv"
  }

  spec {
    capacity = {
      storage = "10Gi"
    }

    access_modes = ["ReadWriteOnce"]

    persistent_volume_source {
      aws_elastic_block_store {
        volume_id = aws_ebs_volume.authentik_data.id
      }
    }
  }
}

# PersistentVolumeClaim (PVC) for Authentik
resource "kubernetes_persistent_volume_claim" "authentik_pvc" {
  metadata {
    name = "authentik-pvc"
    namespace = "default"
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "10Gi"
      }
    }

    volume_name = kubernetes_persistent_volume.authentik_pv.metadata[0].name
  }
}

# Helm Release for Authentik
resource "helm_release" "authentik" {
  name       = "authentik"
  repository = "https://charts.goauthentik.io"
  chart      = "authentik"
  version    = var.authentik_version

  set {
    name  = "postgresql.enabled"
    value = "true"
  }

  set {
    name  = "postgresql.persistence.storageClass"
    value = "gp2" 
  }

  set {
    name  = "externalDatabase.host"
    value = var.db_endpoint
  }

  set {
    name  = "externalDatabase.user"
    value = var.db_username
  }

  set {
    name  = "externalDatabase.password"
    value = var.db_password
  }

  set {
    name  = "externalDatabase.database"
    value = var.db_name
  }

  set {
    name  = "persistence.enabled"
    value = "true"
  }

  set {
    name  = "persistence.size"
    value = "10Gi"
  }

  set {
    name  = "externalDatabase.port"
    value = "5432"  
  }

  set {
    name  = "persistence.existingClaim"
    value = kubernetes_persistent_volume_claim.authentik_pvc.metadata[0].name
  }

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "service.targetPort"
    value = "9000"
  }

  set {
    name  = "service.port"
    value = "9000"
  }

}
