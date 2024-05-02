provider "aws" {
  region = var.region
}

module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr_block      = var.vpc_cidr_block
  subnet1_cidr_block  = var.subnet1_cidr_block
  availability_zone   = var.availability_zone
  vpc_name            = var.vpc_name
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "route53" {
  source      = "./modules/route53"
  domain_name = var.domain_name
  region      = var.region
}

module "acm" {
  source           = "./modules/acm"
  domain_name      = var.domain_name
  alternative_name = var.alternative_name
  route53_zone_id  = module.route53.zone_id
}

module "alb" {

  source                  = "./modules/alb"
  vpc_name                = module.vpc.vpc_name
  alb_security_group_id   = module.sg.alb_security_group_id
  subnet1                 = module.vpc.subnet1
  vpc_id                  = module.vpc.vpc_id
  certificate_arn         = module.acm.certificate_arn
}

module "ecr" {
  source           = "./modules/ecr"
  repository_name  = var.repository_name
}


module "rds" {
  source              = "./modules/rds"
  db_password         = var.db_password
  }

module "s3cloudfront" {

  source = "./modules/s3cloudfront"
  bucket_name           = var.bucket_name
  certificate_arn       = module.acm.certificate_arn
  distribution_name     = var.distribution_name
}

module "iamrole" {
  source    = "./modules/iamrole"
  role_name = "var.role_name"
}

module "ecs" {
  source = "./modules/ecs"

  cluster_name                  = var.cluster_name
  task_name                     = var.task_name
  role_arn            = module.iamrole.role_arn
  network_mode                  = var.network_mode
  requires_compatibilities    = var.requires_compatibilities
  task_cpu                      = var.task_cpu
  task_memory                   = var.task_memory
  container_name                = var.container_name
  container_image               = var.container_image
  container_port                = var.container_port
  host_port                     = var.host_port
  aws_region                    = var.region
  minimum_healthy_percent       = var.minimum_healthy_percent
  maximum_percent               = var.maximum_percent
  platform_version              = var.platform_version
  desired_count                 = var.desired_count
  enable_managed_tags           = var.enable_managed_tags
  propagate_tags                = var.propagate_tags
  target_group_arn              = module.alb.alb_target_group_arn
}