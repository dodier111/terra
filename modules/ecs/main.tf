resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.cluster_name}-cluster"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

# Create CloudWatch log group
resource "aws_cloudwatch_log_group" "log_group" {
  name = "${var.task_name}-task-definition"

  lifecycle {
    create_before_destroy = true
  }
}

# Create ECS task definition
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                    = "${var.task_name}-task-definition"
  execution_role_arn        = var.role_arn
  network_mode              = var.network_mode
  requires_compatibilities  = var.requires_compatibilities
  cpu                       = var.task_cpu
  memory                    = var.task_memory

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions     = jsonencode([
    {
      name                  = "${var.container_name}-container"
      image                 = var.container_image
      essential             = true

      portMappings          = [
        {
          containerPort     = var.container_port
          hostPort          = var.host_port
        }
      ]
      
      ulimits = [
        {
          name = "nofile",
          softLimit = 1024000,
          hardLimit = 1024000
        }
      ]

      logConfiguration = {
        logDriver   = "awslogs"
        options     = {
          "awslogs-group"          = aws_cloudwatch_log_group.log_group.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix"  = "${var.task_name}-stream"
        }
      }
    }
  ])
}

# Create ECS service
resource "aws_ecs_service" "ecs_service" {
  name                            = "my-ecs-service"
  launch_type                     = "FARGATE"
  cluster                         = aws_ecs_cluster.ecs_cluster.arn
  task_definition                 = aws_ecs_task_definition.ecs_task_definition.arn
  platform_version                = var.platform_version
  desired_count                   = var.desired_count
  deployment_minimum_healthy_percent = var.minimum_healthy_percent
  deployment_maximum_percent     = var.maximum_percent

  # Task tagging configuration
  enable_ecs_managed_tags        = var.enable_managed_tags
  propagate_tags                 = var.propagate_tags

 

  # Load balancing
  load_balancer {
    target_group_arn             = var.target_group_arn
    container_name               = "${var.container_name}-container"
    container_port               = var.container_port
  }
}
