# Terraform Database Reliability Assessment

## Project Implementation

---

# Phase 1: Project Overview

## Objective

The objective of this assessment is to design a production-oriented AWS infrastructure using Terraform and automate infrastructure validation using GitHub Actions. The project follows **Infrastructure as Code (IaC)** principles by organizing reusable Terraform modules and separate environments for **Development** and **Production**.

## Technologies Used

- Terraform
- AWS
- Git & GitHub
- GitHub Actions


> **Project Folder Structure**

<img width="645" height="634" alt="image" src="https://github.com/user-attachments/assets/ab49b1c8-3166-463f-b20e-bc3f189288c6" />


---

# Phase 2: AWS Environment Setup

## Launch EC2 Instance

An Ubuntu EC2 instance was created to develop and test the Terraform project.

### Instance Configuration

| Configuration | Value |
|--------------|-------|
| AMI | Ubuntu Server 24.04 LTS |
| Instance Type | t3.micro |
| Storage | 30 GB EBS |
| Region | us-east-1 |

Initially, the project was started using a **t2.micro** instance. As additional packages such as Terraform, Git, and AWS CLI were installed, the root volume ran out of storage. To continue working without resizing the instance immediately, swap memory was temporarily configured. Later, a **t3.micro** instance with sufficient storage was used for the project.


<img width="1090" height="294" alt="image" src="https://github.com/user-attachments/assets/2a8e97ad-85c7-4ce3-b630-334f9dd18b82" />


---

## Install Required Software

The following tools were installed on the EC2 instance:

- Git
- Terraform
- AWS CLI
- Tree
- Curl
- Unzip

These tools are required to develop, validate, and manage the Terraform infrastructure.


<img width="622" height="113" alt="image" src="https://github.com/user-attachments/assets/4543fc05-9d0e-4765-80bc-e63fd44ea862" />


---

## Configure AWS CLI

AWS CLI was configured using IAM User Access Keys.

```bash
aws configure
```

The following values were configured:

- AWS Access Key
- AWS Secret Access Key
- Default Region (`us-east-1`)
- Output Format (`json`)

This allows Terraform to authenticate and provision AWS resources securely.

<img width="586" height="39" alt="image" src="https://github.com/user-attachments/assets/00e0380a-c991-4564-8701-f26c06463590" />


<img width="622" height="126" alt="image" src="https://github.com/user-attachments/assets/3efccc20-c3af-4691-867d-48e99e2544f8" />


---

# Phase 3: Terraform Project Structure

## Project Directory

The project follows a modular Terraform architecture.

```text
Terraform-db-assessment/

├── infra
│   ├── modules
│   │   ├── network
│   │   ├── ecs
│   │   └── rds
│   │
│   └── envs
│       ├── dev
│       └── prod
│
├── database
├── scripts
└── README.md
```

Using modules improves code reusability and maintainability, while separate environments enable different configurations for Development and Production.



---

## Network Module

A reusable Terraform module was created to provision networking resources.

### Resources Created

- VPC
- Internet Gateway
- Public Subnets
- Private Subnets
- Route Tables
- Route Table Associations

This module provides the networking foundation required for ECS and RDS deployment.

<img width="627" height="122" alt="image" src="https://github.com/user-attachments/assets/1e8d55b9-2333-4cd7-bf0b-53a0adb61fa0" />

<img width="626" height="288" alt="image" src="https://github.com/user-attachments/assets/8c81b2e6-6667-4a9c-b615-3957605645d1" />

---

## ECS Module

A separate module was created to provision the compute layer.

### Resources Created

- ECS Cluster
- ECS Task Definition
- ECS Service
- Application Load Balancer (ALB)
- Target Group
- Listener
- Security Groups
- IAM Roles

The ECS service is configured to run a sample **Nginx** container using **AWS Fargate**.

<img width="622" height="98" alt="image" src="https://github.com/user-attachments/assets/8140cf38-5511-411b-98b4-ba86ed249bd5" />

<img width="211" height="93" alt="image" src="https://github.com/user-attachments/assets/cc8b7374-5370-4a00-85f4-7f101e5f54b7" />

<img width="510" height="126" alt="image" src="https://github.com/user-attachments/assets/5450ebae-85c4-4aeb-90c0-ebd168f09790" />

---

## Environment Configuration

Separate environment configurations were created.

### Development Environment

The Development environment uses:

- Smaller resource sizes
- Lower backup retention
- Deletion protection disabled

Environment-specific configuration files include:

- `provider.tf`
- `variables.tf`
- `terraform.tfvars`
- `backend.tf`
- `main.tf`

This structure allows infrastructure settings to differ between Development and Production while reusing the same Terraform modules.


---

# Phase 4: Terraform Validation


## Terraform Initialization

Terraform was initialized using:

```bash
terraform init
```

During initialization:

- Downloaded required providers
- Initialized backend configuration
- Prepared the working directory


---

## Terraform Validation

The configuration was validated using:

```bash
terraform validate
```

Terraform successfully verified the syntax and configuration of all infrastructure files.


---

## Terraform Plan

Terraform execution plan was generated using:

```bash
terraform plan
```

The plan displayed all AWS resources that would be created without actually provisioning them.

### Resources Included

- VPC
- Public & Private Subnets
- Internet Gateway
- Route Tables
- ECS Cluster
- ECS Service
- Application Load Balancer
- Target Group
- IAM Roles
- Security Groups

This confirms that the Terraform configuration is syntactically correct and deployment-ready.

---

# Phase 5: GitHub Repository

## Push Project to GitHub

After completing the Terraform project, the source code was pushed to GitHub.

Git commands used:

```bash
git init
git add .
git commit -m "Initial Commit"
git branch -M main
git remote add origin <repository-url>
git push -u origin main
```

This enables version control and collaboration using GitHub.


<img width="890" height="387" alt="image" src="https://github.com/user-attachments/assets/3592e233-9108-40ba-b1c9-d43cb6f3fbcf" />


---

# Phase 6: GitHub Actions CI Pipeline

## Overview

GitHub Actions was implemented to automate Terraform validation whenever code is pushed or a Pull Request is created.

### Workflow Steps

- Checkout Repository
- Setup Terraform
- Configure AWS Credentials
- Terraform Format Check
- Terraform Initialization
- Terraform Validation
- Terraform Plan
- Upload Terraform Plan Artifact

This CI pipeline helps identify infrastructure issues early and ensures Terraform configurations remain valid before deployment.


<img width="360" height="589" alt="image" src="https://github.com/user-attachments/assets/54b979c1-7d36-4a5d-a8dd-b89194550936" />


---

## GitHub Secrets

Sensitive AWS credentials were securely stored using GitHub Secrets instead of hardcoding them into the repository.

### Secrets Used

| Secret | Purpose |
|---------|---------|
| `AWS_ACCESS_KEY_ID` | Authenticates Terraform with AWS |
| `AWS_SECRET_ACCESS_KEY` | Provides secure access to AWS resources |


<img width="626" height="118" alt="image" src="https://github.com/user-attachments/assets/8f37dda5-d436-4b97-87d3-b6f8b9689939" />


---

## GitHub Actions Result

After configuring the workflow and GitHub Secrets, the CI pipeline completed successfully.

### Completed Tasks

- ✅ Repository Checkout
- ✅ Terraform Setup
- ✅ AWS Authentication
- ✅ Terraform Format Check
- ✅ Terraform Initialization
- ✅ Terraform Validation
- ✅ Terraform Plan Generation
- ✅ Upload Terraform Plan Artifact


<img width="1333" height="455" alt="image" src="https://github.com/user-attachments/assets/d86690ee-63aa-45cc-9c90-95dadf500aa9" />


---
