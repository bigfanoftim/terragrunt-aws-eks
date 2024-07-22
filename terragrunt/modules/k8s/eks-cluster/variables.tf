# ---------------------------------------------------------------------------------------------------------------------
# iam role
# ---------------------------------------------------------------------------------------------------------------------
variable "eks_cluster_role" {
  type = object({
    name               = string
    assume_role_policy = string
    tags               = map(string)
  })
}

variable "eks_cluster_role_policy_attachments" {
  type    = list(string)
  default = ["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"]
}

variable "eks_node_group_role" {
  type = object({
    name               = string
    assume_role_policy = string
    tags               = map(string)
  })
}

variable "eks_node_group_role_policy_attachments" {
  type    = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# eks cluster, security group
# ---------------------------------------------------------------------------------------------------------------------
variable "eks_cluster" {
  type = object({
    name = string

    vpc_config = object({
      subnet_ids              = list(string)
      endpoint_private_access = bool
      endpoint_public_access  = bool
    })
  })
}

variable "eks_cluster_security_group" {
  type = object({
    description = string
    name        = string
    vpc_id      = string

    vpc_sg_ingress_rules_ipv4 = list(object({
      cidr_ipv4   = string
      from_port   = number
      ip_protocol = string
      to_port     = number

      description = string
    }))

    vpc_sg_ingress_rules_security_group_reference = list(object({
      referenced_security_group_id = string
      from_port                    = number
      ip_protocol                  = string
      to_port                      = number

      description = string
    }))

    vpc_sg_egress_rules_ipv4 = list(object({
      cidr_ipv4   = string
      from_port   = number
      ip_protocol = string
      to_port     = number

      description = string
    }))

    tags = map(string)
  })
}

# ---------------------------------------------------------------------------------------------------------------------
# node group
# ---------------------------------------------------------------------------------------------------------------------
variable "node_groups" {
  type = map(object({
    node_group_name      = string
    subnet_ids           = list(string)
    ami_type             = string
    capacity_type        = string
    disk_size            = number
    force_update_version = bool
    instance_types       = list(string)

    scaling_config = object({
      desired_size = number
      max_size     = number
      min_size     = number
    })

    remote_access = object({
      ec2_ssh_key               = string
      source_security_group_ids = optional(list(string))
    })
  }))
}
