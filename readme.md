# Terraform AWS Infrastructure Deployment (Modular & Parameterized)

This project uses Terraform to deploy a modularized and parameterized AWS infrastructure, comprising:

- **VPC** with a public subnet  
- **Internet Gateway** and **Route Table** for public internet access  
- **Security Group** allowing HTTP (80) and SSH (22) traffic  
- **EC2 instance** running an Apache web server with a custom portfolio webpage  
- **CloudWatch billing alarm** sending SNS email notifications  

## Project Highlights

- Infrastructure split into reusable modules (vpc, subnet, internet_gateway, route_table, security_group, ec2, billing_alert)  
- Variables and outputs fully parameterized for flexibility  
- EC2 user data bootstraps Apache and serves a portfolio HTML page  
- Billing alarm notifies via email on AWS cost threshold breach  

## Prerequisites

- Terraform (v1.x recommended) installed  
- AWS CLI configured with credentials having necessary IAM permissions (EC2, VPC, SNS, CloudWatch, etc.)  
- Basic understanding of Terraform modules and variables  

## Folder Structure

```

terraform-aws-project/
│
├── main.tf            # Root module calling all child modules
├── variables.tf       # Input variables for root module
├── outputs.tf         # Outputs from root module
├── terraform.tfvars   # Values for root module variables
├── user\_data.sh       # EC2 bootstrap script for Apache and portfolio page
│
├── vpc/
│   ├── main.tf        # VPC module resources
│   ├── variables.tf   # VPC module variables
│   ├── outputs.tf     # VPC module outputs
│
├── subnet/
│   ├── main.tf        # Subnet module resources
│   ├── variables.tf   # Subnet module variables
│   ├── outputs.tf     # Subnet module outputs
│
├── internet\_gateway/
│   ├── main.tf        # Internet Gateway module resources
│   ├── variables.tf   # Internet Gateway module variables
│   ├── outputs.tf     # Internet Gateway module outputs
│
├── route\_table/
│   ├── main.tf        # Route Table module resources
│   ├── variables.tf   # Route Table module variables
│   ├── outputs.tf     # Route Table module outputs
│
├── security\_group/
│   ├── main.tf        # Security Group module resources
│   ├── variables.tf   # Security Group module variables
│   ├── outputs.tf     # Security Group module outputs
│
├── ec2/
│   ├── main.tf        # EC2 module resources
│   ├── variables.tf   # EC2 module variables
│   ├── outputs.tf     # EC2 module outputs
│
└── billing\_alert/
├── main.tf        # Billing alert module resources
├── variables.tf   # Billing alert module variables
├── outputs.tf     # Billing alert module outputs
│
├── s3_static_site/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── site-content/
│        ├── index.html
│        └── error.html

````

## Usage

1. Clone the repository  
2. Update `terraform.tfvars` to customize variables (AMI, instance type, alert email, etc.)  
3. Run the following Terraform commands:

```
terraform init
terraform plan
terraform apply -auto-approve
````

4. After deployment, Terraform outputs the EC2 instance’s public IP. Visit it in a browser to see your portfolio webpage.

## Customization

* Edit `user_data.sh` to update the Apache-served webpage content
* Change module input variables via `terraform.tfvars` or `variables.tf`
* Adjust billing alert email or threshold in the `billing_alert` module variables

---
