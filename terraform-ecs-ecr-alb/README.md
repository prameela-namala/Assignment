# 🚀 ECS Fargate CI/CD Pipeline with Terraform

## 📌 Overview

This project demonstrates an end-to-end DevOps pipeline that builds, tests, containerizes, and deploys an application to AWS ECS Fargate using Infrastructure as Code and CI/CD automation.

---

## 🧱 Architecture

The system includes:

* CI/CD pipeline using GitHub Actions
* Container image storage in Amazon ECR
* Infrastructure provisioned using Terraform
* Application deployed on Amazon ECS Fargate
* Traffic routed via Application Load Balancer
* Monitoring and alerting using CloudWatch

---

## ⚙️ Tech Stack

* **Language**: Node.js / Python
* **Containerization**: Docker
* **Infrastructure**: Terraform
* **Cloud**: AWS (ECS, ECR, VPC, ALB, IAM, CloudWatch)
* **CI/CD**: GitHub Actions

---

## 📂 Project Structure

```
.
├── frontend                 # Application source code
│   ├── assets 
│   
│   Dockerfile
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│
├── .github/workflows/
│   └── deploy.yml
│
└── README.md
```

---

## 🔄 CI/CD Pipeline Flow

1. Developer pushes code to GitHub
2. GitHub Actions triggers pipeline:

   * Run lint checks
   * Execute unit tests
   * Build Docker image
   * Push image to Amazon ECR
   * Deploy to ECS Fargate
3. ECS pulls latest image and updates service

---

## 🛠️ Setup Instructions

### 1. Prerequisites

* AWS CLI configured
* Terraform installed
* GitHub repository

---

### 2. Clone Repository

```bash
git clone <repo-url>
cd Assignment
```

---

### 3. Provision Infrastructure

```bash
cd terraform-ecs-ecr-alb
terraform init
terraform apply -var-file=dev.tfvars -auto-approve
```

This will create:

* VPC, subnets
* ECS cluster & service
* ALB
* IAM roles
* CloudWatch logs

---

### 4. Configure GitHub Secrets

Add the following secrets in your repo:

* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY
* AWS_REGION
* ECR_REPOSITORY

---

### 5. Trigger Deployment

Push code to main branch:

```bash
git push origin main
```

Pipeline will:

* Build Docker image
* Push to ECR
* Deploy to ECS

---

## 🔁 Deployment Strategy

* Uses **rolling updates** (default ECS)

---

## 📊 Monitoring & Alerts

* Logs stored in CloudWatch Logs
* Metrics tracked via CloudWatch
* Alarms configured for:

  * High CPU usage
  * Service failures
  * Unhealthy targets

---

### Manual rollback:

```bash
aws ecs update-service \
  --cluster <cluster-name> \
  --service <service-name> \
  --force-new-deployment
```

Or redeploy previous image tag.


## 🐞 Troubleshooting

### ❌ Deployment Failed

* Check GitHub Actions logs
* Verify ECR image exists

### ❌ Service Not Running

* Check ECS service events
* Verify task definition

### ❌ No Logs

* Check CloudWatch log group
* Ensure IAM role has permissions

### ❌ ALB Not Routing

* Check target group health
* Verify security groups

---

## 🔐 Security

* IAM roles follow least privilege
* Private subnets used for ECS tasks
* Secrets managed via GitHub Secrets

---

## 📈 Future Improvements

* Add autoscaling for ECS service
* Implement canary deployments
* Use AWS Secrets Manager
* Add Terraform remote backend


