variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  default = "main-vpc"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "availability_zone" {
  default = "us-east-1a"
}

variable "subnet_name" {
  default = "public-subnet"
}

variable "route_table_name" {
  default = "public-rt"
}

variable "sg_name" {
  default = "web-sg"
}

variable "sg_description" {
  default = "Allow HTTP and SSH"
}

variable "ami_id" {
  default = "ami-0c02fb55956c7d316"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "instance_name" {
  default = "web-server"
}

variable "alert_email" {
  default = "umar.mak@gmail.com"
}
