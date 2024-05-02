availability_zone  = "us-east-1a"
vpc_name           = "MainVPC"
domain_name        = "terraabel.com"
alternative_name   = "*.terraabel.com"
region             = "us-east-1"
repository_name    = "example-repo"
db_password        = "password"
bucket_name        = "abelterrr"
distribution_name  = "terrrabel"   
role_name          = "ecsTaskExecutionRole"
cluster_name                = "my-ecs-cluster"
task_name                   = "my-task"
network_mode                = "awsvpc"
requires_compatibilities    = ["FARGATE"]
task_cpu                    = "256"
task_memory                 = "512"
container_name              = "my-container"
container_image             = "nginx:latest"
container_port              = 80
host_port                   = 80
minimum_healthy_percent     = 50
maximum_percent             = 200
platform_version            = "1.4.0"
desired_count               = 2
enable_managed_tags         = true
propagate_tags              = "SERVICE"