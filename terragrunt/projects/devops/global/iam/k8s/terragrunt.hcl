include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../modules/iam"
}

inputs = {
  iam_user = {
    name = "k8s-admin"
  }

  iam_policy = {
    name        = "k8s-admin-policy"
    description = "IAM policy for k8s-admin"
    policy      = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "eks:DescribeCluster",
            "eks:ListClusters",
            "eks:ListUpdates",
            "eks:DescribeUpdate",
            "eks:DescribeNodegroup",
            "eks:ListNodegroups",
            "eks:DescribeNodegroupScalingConfig",
            "eks:UpdateNodegroupConfig",
            "eks:UpdateNodegroupVersion",
            "eks:CreateNodegroup",
            "eks:DeleteNodegroup"
          ],
          "Resource" : "*"
        }
      ]
    })
  }
}
