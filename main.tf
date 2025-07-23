provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0c02fb55956c7d316"  
  instance_type = "t3.micro"              # Confirm free-tier eligible
  associate_public_ip_address = true
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

 user_data = <<-EOT
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<!DOCTYPE html>
    <html>
    <head>
      <title>Mubarak Ahmad Khan | Portfolio</title>
      <style>
        body { font-family: Arial, sans-serif; padding: 40px; }
        h1 { color: #333; }
        .section { margin-bottom: 30px; }
      </style>
    </head>
    <body>
      <h1>👋 Hi, I'm Mubarak Ahmad Khan</h1>
      <div class='section'>
        <h2>🌐 About Me</h2>
        <p>Cloud Engineer | DevOps Enthusiast | Python Developer</p>
      </div>
      <div class='section'>
        <h2>💼 Projects</h2>
        <ul>
          <li>Terraform AWS Infrastructure Deployment</li>
          <li>CARLA Autonomous Driving Simulation</li>
        </ul>
      </div>
      <div class='section'>
        <h2>📫 Contact</h2>
        <p>Email: mubarak.khan@outlook.com</p>
      </div>
    </body>
    </html>" > /var/www/html/index.html
  EOT


  tags = {
    Name = "web-server"
  }

  lifecycle {
    create_before_destroy = true
  }
}


output "instance_public_ip" {
  value = aws_instance.web.public_ip
}
