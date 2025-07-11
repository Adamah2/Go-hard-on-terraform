# Create local variable for naming conventions
locals {
  name_prefix = "${var.owner}-${var.environment}-${var.region}"

  # Common tags
  common_tags = {
    Owner       = var.owner
    Environment = var.environment
    Region      = var.region
  }

  # Resource names
  jump_server_name         = "${local.name_prefix}-jump-server"
  target_group_name        = "${var.owner}-${var.environment}-tg"
  alb_name                 = "${local.name_prefix}-alb"
  ecr_repo_name            = "${local.name_prefix}-ecr-repo"
  ecs_task_name            = "${local.name_prefix}-ecs-task"
  asg_name                 = "${local.name_prefix}-asg"
  ecs_cluster_name         = "${local.name_prefix}-ecs-cluster"
  ecs_service_name         = "${local.name_prefix}-ecs-service"
  ecs_task_definition_name = "${local.name_prefix}-ecs-task-definition"

  # Container definitions (from template)
  container_definitions = templatefile("${path.root}/Policies/container-definitions.json", {
    aws_ecr_repository_url = aws_ecr_repository.ecr_repo.repository_url
    aws_region             = data.aws_region.current.name
    environment            = var.environment
  })

  # Jump subnet ID fetched from SSM
  jump_subnet_id = nonsensitive(data.aws_ssm_parameter.jumpbox_subnet.value)
}
