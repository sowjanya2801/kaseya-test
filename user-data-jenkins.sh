#!/bin/bash
sudo yum update –y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y
sudo yum install jenkins java-1.8.0-openjdk-devel -y
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo amazon-linux-extras install ansible2 -y
sudo curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py
sudo python get-pip.py
sudo pip install --ignore-installed winrm
