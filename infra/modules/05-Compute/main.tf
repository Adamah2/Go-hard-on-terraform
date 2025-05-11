# Create Jump Server
module "jump_server" {
  source            = "./modules/jump_server"
  ami_id            = data.aws_ami.ubuntu.id
  instance_type     = var.jump_server_instance_type
  iam_instance_profile = data.aws_iam_instance_profile.jump_profile.name
  security_group_id = data.aws_ssm_parameter.jump_sg_id.value
  subnet_id         = local.jump_subnet_id
  tags              = merge(local.common_tags, { Name = local.jump_server_name })
}

# Create ECR Repository
module "ecr" {
  source          = "./modules/ecr"
  repository_name = local.ecr_repo_name
  tags            = merge(local.common_tags, { Name = local.ecr_repo_name })
}

# Create ECS Cluster
module "ecs_cluster" {
  source       = "./modules/ecs_cluster"
  cluster_name = local.ecs_cluster_name
  tags         = merge(local.common_tags, { Name = local.ecs_cluster_name })
}

# Create ECS Task Definition
module "ecs_task_definition" {
  source             = "./modules/ecs_task_definition"
  family             = local.ecs_task_name
  container_defs     = local.container_definitions
  cpu                = "512"
  memory             = "1024"
  execution_role_arn = data.aws_iam_role.ecs_task_exec_role.arn
  task_role_arn      = data.aws_iam_role.ecs_task_role.arn
  tags               = merge(local.common_tags, { Name = local.ecs_task_name })
}

# Create Target Group for ALB
module "alb_target_group" {
  source         = "./modules/alb_target_group"
  target_name    = local.target_group_name
  container_port = var.container_port
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  tags           = merge(local.common_tags, { Name = local.target_group_name })
}

# Create the ALB
module "alb" {
  source                  = "./modules/alb"
  alb_name                = local.alb_name
  alb_sg_id               = data.aws_ssm_parameter.alb_sg_id.value
  web_subnet_ids          = data.aws_ssm_parameter.web_subnet_ids.value
  drop_invalid_headers    = true
  enable_delete_protection = var.environment == "prod" ? true : false
  tags                    = merge(local.common_tags, { Name = local.alb_name })
}

# Create HTTP → HTTPS Redirect Listener
module "alb_http_listener" {
  source             = "./modules/alb_http_listener"
  alb_arn            = module.alb.arn
  target_group_arn   = module.alb_target_group.arn
  container_port     = var.container_port
}

# Create HTTPS Listener
module "alb_https_listener" {
  source             = "./modules/alb_https_listener"
  alb_arn            = module.alb.arn
  cert_arn           = data.aws_acm_certificate.acm_cert.arn
  target_group_arn   = module.alb_target_group.arn
  alb_https_port     = var.alb_https_listener_port
}

# Associate WAF with ALB
resource "aws_wafv2_web_acl_association" "waf_alb_association" {
  resource_arn = module.alb.arn
  web_acl_arn  = data.aws_ssm_parameter.waf_acl_arn.value
}

# Create Service Discovery Namespace
module "service_discovery_namespace" {
  source       = "./modules/service_discovery_namespace"
  namespace    = "${local.name_prefix}.local"
  description  = "Service Discovery Namespace for ECS"
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  tags         = merge(local.common_tags, { Name = "${local.name_prefix}.local" })
}

# Create Service Discovery Service
module "service_discovery_service" {
  source             = "./modules/service_discovery_service"
  service_name       = local.ecs_service_name
  namespace_id       = module.service_discovery_namespace.id
  tags               = merge(local.common_tags, { Name = local.ecs_service_name })
}

# Create ECS Service
module "ecs_service" {
  source              = "./modules/ecs_service"
  cluster_id          = module.ecs_cluster.id
  task_definition_arn = module.ecs_task_definition.arn
  desired_count       = var.az_count
  subnet_ids          = split(",", data.aws_ssm_parameter.app_subnet_ids.value)
  security_group_id   = data.aws_ssm_parameter.ecs_sg.value
  target_group_arn    = module.alb_target_group.arn
  service_name        = local.ecs_service_name
  container_name      = "app-container"
  container_port      = 80
  registry_arn        = module.service_discovery_service.arn
  tags                = merge(local.common_tags, { Name = local.ecs_service_name })
}

# ECR Lifecycle Policy
resource "aws_ecr_lifecycle_policy" "repo_policy" {
  repository = module.ecr.repository_name
  policy     = file("${path.root}/Policies/ecr-lifecycle-policy.json")

  depends_on = [module.ecr]
}
