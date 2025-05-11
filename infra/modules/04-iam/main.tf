# ---------------------------------------------------
# SSM Role (For EC2 Jump Server with SSM Access)
# ---------------------------------------------------

resource "aws_iam_role" "ssm_role" {
  name               = local.ssm_role_name
  assume_role_policy = data.aws_iam_policy_document.ssm_role_policy.json

  tags = merge(local.common_tags, {
    Name = local.ssm_role_name
  })
}

resource "aws_iam_role_policy_attachment" "ssm_role_policy_attachment" {
  for_each   = toset(var.ssm_policy_arns)
  role       = aws_iam_role.ssm_role.name
  policy_arn = each.value
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = local.ssm_profile_name
  role = aws_iam_role.ssm_role.name
}

# ---------------------------------------------------
# ECS Task Role
# ---------------------------------------------------

resource "aws_iam_role" "ecs_task_role" {
  name               = local.ecs_task_role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_trust_policy.json

  tags = merge(local.common_tags, {
    Name = local.ecs_task_role_name
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_policy_attachment" {
  for_each   = toset(var.ecs_task_policy_arns)
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = each.value
}

# ---------------------------------------------------
# ECS Execution Role
# ---------------------------------------------------

resource "aws_iam_role" "ecs_execution_role" {
  name               = local.ecs_execution_role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_trust_policy.json

  tags = merge(local.common_tags, {
    Name = local.ecs_execution_role_name
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy_attachment" {
  for_each   = toset(var.ecs_execution_policy_arns)
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = each.value
}

# ---------------------------------------------------
# ECS Task Execution Role
# ---------------------------------------------------

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = local.ecs_task_execution_role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_trust_policy.json

  tags = merge(local.common_tags, {
    Name = local.ecs_task_execution_role_name
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy_attachment" {
  for_each   = toset(var.ecs_task_policy_arns)
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = each.value
}

# ---------------------------------------------------
# S3 Role (For Logging Access)
# ---------------------------------------------------

resource "aws_iam_role" "s3_role" {
  name               = local.s3_role_name
  assume_role_policy = data.aws_iam_policy_document.s3_trust_policy.json

  tags = merge(local.common_tags, {
    Name = local.s3_role_name
  })
}

resource "aws_iam_role_policy_attachment" "s3_role_policy_attachment" {
  for_each   = toset(var.s3_policy_arns)
  role       = aws_iam_role.s3_role.name
  policy_arn = each.value
}
