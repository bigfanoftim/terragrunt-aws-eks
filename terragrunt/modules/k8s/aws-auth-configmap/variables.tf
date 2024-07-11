# ---------------------------------------------------------------------------------------------------------------------
# kubeconfig path
# ---------------------------------------------------------------------------------------------------------------------
variable "kubeconfig_path" {
  type        = string
  description = "Path to the kubeconfig file"
}

# ---------------------------------------------------------------------------------------------------------------------
# aws-auth configmap
# ---------------------------------------------------------------------------------------------------------------------
variable "manage_aws_auth_configmap" {
  description = "Determines whether to manage the aws-auth configmap"
  type        = bool
  default     = false
}

variable "aws_auth_users" {
  description = "List of user maps to add to the aws-auth configmap"
  type        = list(any)
  default     = []
}