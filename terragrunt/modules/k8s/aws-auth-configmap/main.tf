# ---------------------------------------------------------------------------------------------------------------------
# k8s provider
# ---------------------------------------------------------------------------------------------------------------------
provider "kubernetes" {
  config_path = var.kubeconfig_path
}

# ---------------------------------------------------------------------------------------------------------------------
# aws-auth configmap
# reference: https://github.com/terraform-aws-modules/terraform-aws-eks/blob/v19.20.0/main.tf#L539
# ---------------------------------------------------------------------------------------------------------------------
locals {
  aws_auth_configmap_data = {
    mapUsers    = yamlencode(var.aws_auth_users)
  }
}

resource "kubernetes_config_map_v1_data" "aws_auth" {
  count = var.manage_aws_auth_configmap ? 1 : 0

  force = true

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = local.aws_auth_configmap_data
}