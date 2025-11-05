# CI/CD Automation Project with AWS, Jenkins, Ansible, Terraform, Docker, Tomcat, and MySQL

## Project Overview
This project implements a full CI/CD pipeline using **Jenkins**, **Ansible**, **Terraform**, and **Docker** on **AWS**. It automates the creation of infrastructure, deployment of applications, and integration with databases. The architecture supports multiple environments (**Dev**, **QA**) with isolated resources.

Key features:
- Automated provisioning of AWS infrastructure using **Terraform** (VPC, Subnets, Security Groups, EC2, IAM)
- Jenkins master and agent setup for CI/CD pipelines
- Ansible for configuration management and deployment
- Dockerized **Tomcat** and **MySQL** containers
- Environment-specific deployments (Dev/QA)
- Passwordless SSH connection setup between Jenkins master and agent nodes
- Integration of Tomcat app with MySQL database using Docker Compose
- Secure management of secrets using **AWS Secrets Manager**

---

## Project Architecture

AWS VPC (Custom)
│
├── Subnet 1 (Masters)
│ └── EC2 Instance: Jenkins Master + Ansible Workstation
│
├── Subnet 2 (Dev Environment)
│ └── EC2 Instance: Dev Application Node
│
├── Subnet 3 (QA Environment)
└── EC2 Instance: Jenkins Agent Node / QA Application Node

- Jenkins master builds and compiles the application.
- Jenkins triggers deployment to Dev and QA environments.
- Docker Compose deploys **Tomcat** and **MySQL** containers per environment.
- Secrets are dynamically injected from AWS Secrets Manager.

## Prerequisites
- Use service account to set up connection
- Jenkins installed on master 
- Terraform v1.5+ installed
- Ansible v2.9+ installed
- Git installed for code checkout
- AWS CLI configured for Terraform and Ansible

## Setup Instructions

### 1. Provision Infrastructure with Terraform

```bash
# Navigate to environment folder
cd terraform/envs/dev

# Initialize Terraform
terraform init

# Apply infrastructure
terraform apply -var-file=terraform.tfvars

Notes:
- Terraform configuration
Modules handle VPC, EC2, Security Groups, IAM separately.
Variables define environment-specific configurations (subnets, instance count, keys, etc.).
Remote backend recommended for state files (S3 + DynamoDB).

- Ansible configuration
cd ansible
ansible-playbook -i inventories/dev/ site.yml --ask-vault-pass
ansible-playbook -i inventories/qa/ site.yml --ask-vault-pass

Playbooks configure EC2 instances, install Docker, Jenkins agent setup, and application deployment.
Use AWS Secrets Manager or Ansible Vault to manage sensitive credentials.

-Deploy Docker Containers
cd docker/dev
docker-compose up -d --build
cd ../qa
docker-compose up -d --build

Dev and QA environments have separate docker-compose.yml and .env.
Tomcat container deploys WAR application; MySQL container handles database storage.
Environment variables (DB_USER, DB_PASSWORD, DB_NAME) are injected from .env or AWS Secrets Manager.

4. Jenkins CI/CD Pipeline

Jenkins master builds code from Git repository.
Pipeline stages:
Checkout: Pull code from Git
Build: Compile WAR file
Test: Optional unit/integration tests
Deploy Dev: Deploy WAR to Dev environment (Docker/Tomcat)
Deploy QA: Deploy WAR to QA environment (manual approval optional)

Jenkins agents execute deployment on environment-specific EC2 nodes.
Passwordless SSH ensures secure communication between master and agents.





