provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./vpc"
}

module "subnet" {
  source            = "./subnet"
  vpc_id            = module.vpc.vpc_id
  subnet_cidr       = var.subnet_cidr
  availability_zone = var.availability_zone
  subnet_name       = var.subnet_name
}


module "internet_gateway" {
  source = "./internet_gateway"
  vpc_id = module.vpc.vpc_id
}

module "route_table" {
  source           = "./route_table"
  vpc_id           = module.vpc.vpc_id
  igw_id           = module.internet_gateway.igw_id
  subnet_id        = module.subnet.subnet_id
  route_table_name = var.route_table_name
}

module "security_group" {
  source         = "./security_group"
  vpc_id         = module.vpc.vpc_id
  sg_name        = var.sg_name
  sg_description = var.sg_description
}

module "ec2" {
  source        = "./ec2"
  subnet_id     = module.subnet.subnet_id
  sg_id         = module.security_group.sg_id
  ami_id        = var.ami_id
  instance_type = var.instance_type
  user_data     = file("user_data.sh")
  instance_name = var.instance_name
}

module "billing_alert" {
  source      = "./billing_alert"
  alert_email = var.alert_email
}


