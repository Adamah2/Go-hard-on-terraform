aws_region      = "eu-west-3"
log_bucket_name = "adamah-bucket"
vpc_cidr        = "10.0.0.0/16"
project_name    = "Go-hard-go-home"
environment     = "dev"
rds_engine      = "mysql"

ssm_policy_arns       = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
ecs_task_policy_arns  = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
ecs_execution_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"]
s3_policy_arns        = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]

# Compute Settings
jump_server_instance_type = "t3.micro"
container_port            = 8080
alb_https_listener_port   = 443
wildcard_domain_name      = "*.example.com"

