# SSM Role Trust Policy (For Jump Server EC2)
data "aws_iam_policy_document" "ssm_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# ECS Roles Trust Policy
data "aws_iam_policy_document" "ecs_trust_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# S3 Logging Role Trust Policy
data "aws_iam_policy_document" "s3_trust_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = [
        "vpc-flow-logs.amazonaws.com",
        "delivery.logs.amazonaws.com",
        "elasticloadbalancing.amazonaws.com"
      ]
    }
  }
}
