#!/bin/bash
set -e

# Update system
yum update -y

# Install Java (Jenkins requirement)
amazon-linux-extras enable java-openjdk11
yum install -y java-11-openjdk

# Add Jenkins repo and key
wget -O /etc/yum.repos.d/jenkins.repo \
  https://pkg.jenkins.io/redhat-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Install Jenkins
yum install -y jenkins

# Start and enable Jenkins
systemctl daemon-reload
systemctl start jenkins
systemctl enable jenkins

# Open Jenkins port (for testing – better via Security Group)
iptables -I INPUT -p tcp --dport 8080 -j ACCEPT || true

# Print initial admin password to log
echo "Jenkins Initial Admin Password:"
cat /var/lib/jenkins/secrets/initialAdminPassword
echo "Jenkins setup complete."