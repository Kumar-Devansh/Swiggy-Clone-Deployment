# 🚀 Terraform AWS EC2 Infrastructure Deployment

A production-style Infrastructure as Code (IaC) project that provisions a complete AWS networking environment and EC2 instance using Terraform.

This project demonstrates how Terraform can automate the provisioning of cloud infrastructure in a clean, scalable, and reproducible way.

---

# 📽️ Live Infrastructure Deployment Demo

> This image demonstrates how Terraform provisions AWS infrastructure step-by-step.

<img width="2816" height="1536" alt="Gemini_Generated_Image_p71hdmp71hdmp71h" src="https://github.com/user-attachments/assets/478b75a2-3c26-4c2d-b364-e35ea33d119f" />



---

# 🏗️ Architecture Overview

The infrastructure created using Terraform includes the following AWS components:

- Custom **VPC**
- **Public Subnet**
- **Internet Gateway**
- **Route Table**
- **Security Group**
- **EC2 Instance**

Terraform provisions all these resources automatically using Infrastructure as Code.

---

# ⚙️ Infrastructure Workflow

The deployment process follows this workflow:

```
Terraform Code
      │
      ▼
AWS Provider Authentication
      │
      ▼
Create VPC
      │
      ▼
Create Public Subnet
      │
      ▼
Attach Internet Gateway
      │
      ▼
Configure Route Table
      │
      ▼
Create Security Group
      │
      ▼
Launch EC2 Instance
```

---

# 📂 Project Structure

```
terraform-aws-ec2-project
│
├── provider.tf
├── variables.tf
├── vpc.tf
├── ec2.tf
├── outputs.tf
├── terraform.tfvars
└── README.md
```

### File Explanation

**provider.tf**

Configures the AWS provider and region for Terraform.

**variables.tf**

Contains reusable input variables for infrastructure configuration.

**vpc.tf**

Defines networking infrastructure including:
- VPC
- Subnet
- Internet Gateway
- Route Tables

**ec2.tf**

Creates the EC2 instance and attaches the security group.

**outputs.tf**

Displays important outputs such as instance public IP.

**terraform.tfvars**

Stores variable values used during deployment.

---

# 🛠️ Technologies Used

- **Terraform**
- **AWS EC2**
- **AWS VPC**
- **Infrastructure as Code (IaC)**
- **GitHub**

---

# 🚀 Deployment Steps

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/yourusername/your-repo-name.git
cd your-repo-name
```

### 2️⃣ Initialize Terraform

```bash
terraform init
```

### 3️⃣ Preview Infrastructure Changes

```bash
terraform plan
```

### 4️⃣ Deploy Infrastructure

```bash
terraform apply
```

Terraform will now provision the complete AWS infrastructure.

---

# 📊 Terraform Outputs

After successful deployment Terraform will output:

- EC2 Public IP
- Instance ID
- VPC ID

---

# 🔐 Security

The project uses a **Security Group** to allow:

- SSH Access (Port 22)

You can modify rules according to your requirements.

---

# 💡 Key Learning Outcomes

- Infrastructure as Code with Terraform
- AWS networking fundamentals
- Automating EC2 deployments
- Modular Terraform configuration
- Cloud infrastructure automation

---

# 📌 Future Improvements

Possible enhancements for this project:

- Add **private subnet**
- Deploy **Nginx on EC2**
- Integrate **CI/CD pipeline**
- Add **Terraform modules**
- Use **remote backend (S3 + DynamoDB)**

---

# 👨‍💻 Author

**Kumar Devansh**

| DevOps & Cloud Enthusiast

---

# ⭐ Support

If you found this project useful, consider giving it a ⭐ on GitHub.
