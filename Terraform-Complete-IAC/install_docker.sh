#!/bin/bash

# Update packages
sudo apt-get update -y

# Install Docker
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

# Add ubuntu user to docker group
sudo usermod -aG docker ubuntu
sudo usermod -aG docker Jenkins

# Apply group change immediately
newgrp docker
sudo chmod 777 /var/run/docker.sock

echo "Docker installed successfully!"
docker --version

# Install Docker Compose Plugin (Docker Compose v2)
sudo apt-get install docker-compose-v2 -y

# Verify installations
docker --version
docker compose version

# ---------------------------
# Install Java (required for Jenkins)
# ---------------------------
sudo apt update -y
sudo apt install fontconfig openjdk-21-jre -y

# ---------------------------
# Install Jenkins
# ---------------------------
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

# Add Jenkins repository
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y
sudo apt install jenkins -y

# Start Jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins

echo "Jenkins installed successfully!"

# Show Jenkins status
sudo systemctl status jenkins

# ---------------------------
# Install SonarQube (Docker)
# ---------------------------
sudo docker volume create sonarqube_data
sudo docker volume create sonarqube_logs
sudo docker volume create sonarqube_extensions

sudo docker run -d \
--name sonarqube \
-p 9000:9000 \
-v sonarqube_data:/opt/sonarqube/data \
-v sonarqube_logs:/opt/sonarqube/logs \
-v sonarqube_extensions:/opt/sonarqube/extensions \
sonarqube:lts

echo "SonarQube started on port 9000"

# ---------------------------
# Install Trivy
# ---------------------------
sudo apt-get install wget apt-transport-https gnupg lsb-release -y

wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | \
gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null

echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] \
https://aquasecurity.github.io/trivy-repo/deb generic main" | \
sudo tee /etc/apt/sources.list.d/trivy.list

sudo apt-get update -y
sudo apt-get install trivy -y

trivy --version

echo "Trivy installed successfully!"
