# 🚀 AWS ECS Fargate Web App (Terraform Project)

This project creates and deploys a simple web application using **AWS cloud services** with Terraform.

It uses containers, so the app runs inside Docker and is managed by AWS automatically.

---

# 🧠 What this project does (Simple explanation)

- Builds a Docker container image of your web app
- Stores the image in **Amazon ECR**
- Runs the container in **Amazon ECS (Fargate)**
- Uses an **Application Load Balancer (ALB)** to send traffic to the app
- Shows logs in **CloudWatch**

---

# 🏗️ Architecture (Easy flow)

User → Load Balancer → ECS Service → Container (App)

Container image comes from → ECR

Logs go to → CloudWatch

---

# ⚙️ AWS Services Used

- Amazon ECR → Stores Docker image
- Amazon ECS (Fargate) → Runs the app
- Application Load Balancer → Sends traffic
- CloudWatch → Stores logs
- IAM Role → Gives permissions
- Security Groups → Controls access

---

# 📁 What Terraform creates

This code automatically creates:

✔ Docker image repository (ECR)  
✔ ECS Cluster  
✔ ECS Service (runs your app)  
✔ Task Definition (container settings)  
✔ Load Balancer (ALB)  
✔ Target Group (connects ALB to ECS)  
✔ Security rules  
✔ CloudWatch log group  
✔ IAM role for permissions  

---

# 🚀 How it works (Step by step)

1. You run Terraform
2. AWS resources are created
3. Docker image is built and pushed to ECR
4. ECS pulls the image
5. App starts running in the cloud
6. ALB gives you a public URL
7. You open the URL and see your app 🎉

---

# 🔐 Security

- Only ALB can access ECS tasks
- ECS tasks have IAM permissions to:
  - Pull images from ECR
  - Send logs to CloudWatch

---

# 🌐 Output

After deployment, you get:

👉 A public load balancer URL  
👉 Running web app in AWS  
👉 Logs in CloudWatch  

---

# 🧰 Requirements

- Terraform installed
- AWS account
- AWS CLI configured
- Docker installed (if building image locally)

---

# 🎯 Purpose of this project

This project is made to learn:

- How cloud deployments work
- How containers run in AWS
- How CI/CD systems deploy applications
- How infrastructure as code works using Terraform
