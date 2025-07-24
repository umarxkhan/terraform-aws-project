variable "vpc_id" {
  description = "VPC ID for the route table"
  type        = string
}

variable "igw_id" {
  description = "Internet Gateway ID to associate with the route"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to associate with the route table"
  type        = string
}

variable "route_table_name" {
  description = "Name of the route table"
  type        = string
}
