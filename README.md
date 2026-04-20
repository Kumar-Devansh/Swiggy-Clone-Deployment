# 🍔 Swiggy Application Deployment using Terraform, Jenkins, SonarQube, Trivy & AWS EKS

This project demonstrates a complete **DevOps CI/CD pipeline** for deploying a Swiggy-like application using modern DevOps tools.

Infrastructure is provisioned using **Terraform**, CI/CD pipeline is managed using **Jenkins**, code quality is analyzed using **SonarQube**, security vulnerabilities are scanned using **Trivy**, and the application is deployed on **AWS EKS Kubernetes cluster**.

---

# 🚀 Project Architecture

Add your architecture diagram here.

![Architecture Diagram](screenshots/architecture.png)

---

# 🧰 Tech Stack

| Tool | Purpose |
|-----|------|
| Terraform | Infrastructure provisioning |
| AWS EC2 | Jenkins server |
| Docker | Containerization |
| Jenkins | CI/CD automation |
| SonarQube | Code quality analysis |
| Trivy | Security vulnerability scanning |
| Kubernetes | Container orchestration |
| AWS EKS | Managed Kubernetes |
| kubectl | Kubernetes CLI |
| AWS CLI | AWS management |
| eksctl | EKS cluster creation |

---

# 📂 Project Structure

```
swiggy-deployment
│
├── main.tf
├── install.sh
├── kubernetes
│   ├── deployment.yaml
│   └── service.yaml
│
├── screenshots
│
└── README.md
```

---

# ⚙️ Step 1 — Provision Infrastructure using Terraform

Initialize Terraform

```bash
terraform init
```

Check execution plan

```bash
terraform plan
```

Apply configuration

```bash
terraform apply -auto-approve
```

📸 Screenshot

![Terraform Apply](screenshots/terraform-apply.png)

---

# 🏗 Terraform Configuration

### main.tf

```hcl
provider "aws" {
  region = "ap-south-1"
}
```

---

# 🖥 Step 2 — Setup Jenkins Server

Run installation script

```bash
chmod +x install.sh
./install.sh
```

📸 Screenshot

![Jenkins Installation](screenshots/jenkins-install.png)

---

# 🐳 Docker Installation

```bash
sudo apt-get update -y
sudo apt-get install -y docker.io

sudo systemctl start docker
sudo systemctl enable docker
```

Add users to docker group

```bash
sudo usermod -aG docker ubuntu
sudo usermod -aG docker Jenkins
```

Apply changes

```bash
newgrp docker
sudo chmod 777 /var/run/docker.sock
```

Verify docker

```bash
docker --version
```

📸 Screenshot

![Docker Installed](screenshots/docker-installed.png)

---

# ⚙ Jenkins Installation

Install Java

```bash
sudo apt update -y
sudo apt install fontconfig openjdk-21-jre -y
```

Add Jenkins repository

```bash
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
```

Add repository

```bash
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null
```

Install Jenkins

```bash
sudo apt update
sudo apt install jenkins -y
```

Start Jenkins

```bash
sudo systemctl start jenkins
sudo systemctl enable jenkins
```

Check status

```bash
sudo systemctl status jenkins
```

Access Jenkins

```
http://<EC2-Public-IP>:8080
```

📸 Screenshot

![Jenkins Dashboard](screenshots/jenkins-dashboard.png)

---

# 🔍 SonarQube Setup (Docker)

Create volumes

```bash
sudo docker volume create sonarqube_data
sudo docker volume create sonarqube_logs
sudo docker volume create sonarqube_extensions
```

Run SonarQube

```bash
sudo docker run -d \
--name sonarqube \
-p 9000:9000 \
-v sonarqube_data:/opt/sonarqube/data \
-v sonarqube_logs:/opt/sonarqube/logs \
-v sonarqube_extensions:/opt/sonarqube/extensions \
sonarqube:lts
```

Access SonarQube

```
http://<EC2-Public-IP>:9000
```

📸 Screenshot

![SonarQube Dashboard](screenshots/sonarqube-dashboard.png)

---

# 🔐 Trivy Installation

```bash
sudo apt-get install wget apt-transport-https gnupg lsb-release -y

wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | \
gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null

echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] \
https://aquasecurity.github.io/trivy-repo/deb generic main" | \
sudo tee /etc/apt/sources.list.d/trivy.list

sudo apt-get update -y
sudo apt-get install trivy -y
```

Verify installation

```bash
trivy --version
```

📸 Screenshot

![Trivy Installed](screenshots/trivy-installed.png)

---

# ☸ Step 3 — Install Kubernetes Tools

## Install kubectl

```bash
sudo apt update
sudo apt install curl

curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

Verify

```bash
kubectl version --client
```

📸 Screenshot

![Kubectl Installed](screenshots/kubectl-version.png)

---

# ☁ Step 4 — Install AWS CLI

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

sudo apt install unzip
unzip awscliv2.zip
sudo ./aws/install
```

Verify

```bash
aws --version
```

📸 Screenshot

![AWS CLI Installed](screenshots/aws-cli.png)

---

# ⚡ Step 5 — Install eksctl

```bash
curl --silent --location \
"https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" \
| tar xz -C /tmp

sudo mv /tmp/eksctl /bin
```

Verify

```bash
eksctl version
```

📸 Screenshot

![eksctl Installed](screenshots/eksctl-version.png)

---

# ☸ Step 6 — Create AWS EKS Cluster

```bash
eksctl create cluster \
--name virtualtechbox-cluster \
--region ap-south-1 \
--node-type t2.small \
--nodes 3
```

Cluster creation takes around **10–15 minutes**

📸 Screenshot

![EKS Cluster](screenshots/eks-cluster.png)

---

# 🔎 Step 7 — Verify Kubernetes Cluster

```bash
kubectl get nodes
kubectl get svc
```

📸 Screenshot

![Kubernetes Nodes](screenshots/k8s-nodes.png)

---

# 🚀 CI/CD Pipeline Flow

```
1 Developer pushes code to GitHub
2 Jenkins pipeline triggers
3 SonarQube performs code analysis
4 Trivy scans Docker image
5 Docker image build
6 Image pushed to registry
7 Application deployed to AWS EKS
```

📸 Screenshot

![Jenkins Pipeline](screenshots/jenkins-pipeline.png)

---

# 🎯 Key Learning Outcomes

✔ Infrastructure as Code using Terraform  
✔ CI/CD Pipeline using Jenkins  
✔ Docker containerization  
✔ Code quality analysis with SonarQube  
✔ Security scanning with Trivy  
✔ Kubernetes deployment  
✔ AWS EKS cluster management  

---

# 👨‍💻 Author

Dev Upadhyay  
DevOps | Cloud | Kubernetes | CI/CD