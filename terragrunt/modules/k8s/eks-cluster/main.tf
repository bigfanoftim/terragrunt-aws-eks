# ---------------------------------------------------------------------------------------------------------------------
# iam role
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_iam_role" "eks_cluster" {
  name               = var.eks_cluster_role.name
  assume_role_policy = var.eks_cluster_role.assume_role_policy
  tags               = var.eks_cluster_role.tags
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  for_each = toset(var.eks_cluster_role_policy_attachments)

  role       = aws_iam_role.eks_cluster.name
  policy_arn = each.value
}

resource "aws_iam_role" "node_group" {
  name               = var.eks_node_group_role.name
  assume_role_policy = var.eks_node_group_role.assume_role_policy
  tags               = var.eks_node_group_role.tags
}

resource "aws_iam_role_policy_attachment" "node_group_policy_attachment" {
  for_each = toset(var.eks_node_group_role_policy_attachments)

  role       = aws_iam_role.node_group.name
  policy_arn = each.value
}

# ---------------------------------------------------------------------------------------------------------------------
# eks cluster
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_eks_cluster" "this" {
  name     = var.eks_cluster.name
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids              = var.eks_cluster.vpc_config.subnet_ids
    endpoint_private_access = var.eks_cluster.vpc_config.endpoint_private_access
    endpoint_public_access  = var.eks_cluster.vpc_config.endpoint_public_access
    security_group_ids      = [aws_security_group.eks_cluster.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy_attachment
  ]
}

resource "aws_security_group" "eks_cluster" {
  description = var.eks_cluster_security_group.description
  name        = var.eks_cluster_security_group.name
  vpc_id      = var.eks_cluster_security_group.vpc_id

  revoke_rules_on_delete = true

  tags = var.eks_cluster_security_group.tags
}

resource "aws_vpc_security_group_ingress_rule" "eks_cluster" {
  for_each = { for idx, rule in var.eks_cluster_security_group.vpc_sg_ingress_rules_ipv4 : idx => rule }

  security_group_id = aws_security_group.eks_cluster.id

  cidr_ipv4   = each.value.cidr_ipv4
  from_port   = each.value.from_port
  ip_protocol = each.value.ip_protocol
  to_port     = each.value.to_port

  description = each.value.description
}

resource "aws_vpc_security_group_ingress_rule" "eks_cluster_security_group_reference" {
  for_each = {
    for idx, rule in var.eks_cluster_security_group.vpc_sg_ingress_rules_security_group_reference : idx =>rule
  }

  security_group_id = aws_security_group.eks_cluster.id

  referenced_security_group_id = each.value.referenced_security_group_id
  from_port                    = each.value.from_port
  ip_protocol                  = each.value.ip_protocol
  to_port                      = each.value.to_port

  description = each.value.description
}

resource "aws_vpc_security_group_egress_rule" "eks_cluster" {
  for_each = { for idx, rule in var.eks_cluster_security_group.vpc_sg_egress_rules_ipv4 : idx => rule }

  security_group_id = aws_security_group.eks_cluster.id

  cidr_ipv4   = each.value.cidr_ipv4
  from_port   = each.value.from_port
  ip_protocol = each.value.ip_protocol
  to_port     = each.value.to_port

  description = each.value.description
}

# ---------------------------------------------------------------------------------------------------------------------
# node group
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_eks_node_group" "this" {
  cluster_name  = aws_eks_cluster.this.name
  node_role_arn = aws_iam_role.node_group.arn

  node_group_name      = var.node_group.node_group_name
  subnet_ids           = var.node_group.subnet_ids
  ami_type             = var.node_group.ami_type
  capacity_type        = var.node_group.capacity_type
  disk_size            = var.node_group.disk_size
  force_update_version = var.node_group.force_update_version
  instance_types       = var.node_group.instance_types

  scaling_config {
    desired_size = var.node_group.scaling_config.desired_size
    max_size     = var.node_group.scaling_config.max_size
    min_size     = var.node_group.scaling_config.min_size
  }

  remote_access {
    ec2_ssh_key               = var.node_group.remote_access.ec2_ssh_key
    source_security_group_ids = var.node_group.remote_access.source_security_group_ids == null ? null : var.node_group.remote_access.source_security_group_ids
  }

  depends_on = [
    aws_eks_cluster.this,
    aws_iam_role_policy_attachment.node_group_policy_attachment
  ]
}
