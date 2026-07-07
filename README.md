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

### Screenshot

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

### Screenshot

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

### Screenshot

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

### Screenshot



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

### Screenshot

![Project Tree](screenshots/tree-output.png)

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

### Screenshot

![Network Module](screenshots/network-module.png)

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

### Screenshot

![ECS Module](screenshots/ecs-module.png)

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

### Screenshot

![Development Environment](screenshots/dev-environment.png)

---

# Phase 4: Terraform Validation

## Terraform Formatting

Terraform formatting was verified using:

```bash
terraform fmt -recursive
```

This command ensures that all Terraform files follow HashiCorp's recommended formatting standards.

### Screenshot

![Terraform Format](screenshots/terraform-fmt.png)

---

## Terraform Initialization

Terraform was initialized using:

```bash
terraform init
```

During initialization:

- Downloaded required providers
- Initialized backend configuration
- Prepared the working directory

### Screenshot

![Terraform Init](screenshots/terraform-init.png)

---

## Terraform Validation

The configuration was validated using:

```bash
terraform validate
```

Terraform successfully verified the syntax and configuration of all infrastructure files.

### Screenshot

![Terraform Validate](screenshots/terraform-validate.png)

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

### Screenshot

![Terraform Plan](screenshots/terraform-plan.png)

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

### Screenshot

![GitHub Repository](screenshots/github-repository.png)

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

### Screenshot

![GitHub Actions Workflow](screenshots/github-actions.png)

---

## GitHub Secrets

Sensitive AWS credentials were securely stored using GitHub Secrets instead of hardcoding them into the repository.

### Secrets Used

| Secret | Purpose |
|---------|---------|
| `AWS_ACCESS_KEY_ID` | Authenticates Terraform with AWS |
| `AWS_SECRET_ACCESS_KEY` | Provides secure access to AWS resources |

### Screenshot

![GitHub Secrets](screenshots/github-secrets.png)

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

### Screenshot

![Successful Workflow](screenshots/workflow-success.png)

---
