variable "subnet_id" {
  description = "ID of the Subnet"
  type        = string
}

variable "sg_id" {
  description = "ID of the Security Group"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "user_data" {
  description = "User data script"
  type        = string
}

variable "instance_name" {
  description = "Tag name for the EC2 instance"
  type        = string
}
