resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  associate_public_ip_address = true
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_id]

  user_data = var.user_data

  tags = {
    Name = var.instance_name
  }

  lifecycle {
    create_before_destroy = true
  }
}
