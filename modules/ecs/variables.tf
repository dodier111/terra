variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "task_name" {
  description = "Name of the ECS task"
  type        = string
}

variable "role_arn" {
  description = "The ARN of the IAM role that allows ECS to execute tasks"
  type        = string
}

variable "network_mode" {
  description = "The network mode to use for the containers in the task"
  type        = string
}

variable "requires_compatibilities" {
  description = "A set of launch types required by the task"
  type        = list(string)
}

variable "task_cpu" {
  description = "The amount of CPU units to reserve for the container"
  type        = string
}

variable "task_memory" {
  description = "The amount of memory to reserve for the container"
  type        = string
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "container_image" {
  description = "The Docker image to use for the container"
  type        = string
}

variable "container_port" {
  description = "The port on which the container listens for traffic"
  type        = number
}

variable "host_port" {
  description = "The port on the container instance to reserve for your container"
  type        = number
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "minimum_healthy_percent" {
  description = "The minimum number of tasks to keep in the RUNNING state during a deployment"
  type        = number
}

variable "maximum_percent" {
  description = "The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment"
  type        = number
}

variable "platform_version" {
  description = "The platform version on which to run the service"
  type        = string
}

variable "desired_count" {
  description = "The number of instances of the task definition to place and keep running"
  type        = number
}

variable "enable_managed_tags" {
  description = "Specifies whether to enable Amazon ECS managed tags for the task"
  type        = bool
}

variable "propagate_tags" {
  description = "Specifies whether to propagate the tags from the task definition or the service to the task"
  type        = string
}


variable "target_group_arn" {
  description = "The ARN of the target group associated with the ECS service"
  type        = string
}
