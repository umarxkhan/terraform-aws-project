# Terraform AWS Infrastructure Deployment

This project uses Terraform to deploy a basic AWS infrastructure, including:

- A VPC with a public subnet
- An Internet Gateway and Route Table for public access
- A security group allowing HTTP (80) and SSH (22) traffic
- An EC2 instance running a simple web server with a custom HTML page
- A CloudWatch billing alarm with SNS email notification

## Project Features

- Automates AWS infrastructure provisioning using Terraform
- EC2 instance user data sets up Apache HTTP server and serves a portfolio webpage
- Billing alarm alerts you via email when AWS charges exceed $1
- Customizable infrastructure as code for learning and portfolio demonstration

## Prerequisites

- Terraform installed (version 1.x recommended)
- AWS CLI configured with appropriate IAM credentials
- AWS account with permissions to create EC2, VPC, SNS, CloudWatch, etc.

## Usage

1. Clone the repo and navigate to the project directory.
2. Update the email address in `main.tf` for SNS subscription.
3. Run the following Terraform commands:

```bash
terraform init
terraform plan
terraform apply -auto-approve

4. After deployment, note the EC2 instance public IP output and visit it in a browser to see your portfolio webpage.


## Customization

- Modify the user_data section in main.tf to update the web content.
- Adjust VPC, subnet, security groups, or instance type as needed.
- Change billing alarm threshold and notification email.
