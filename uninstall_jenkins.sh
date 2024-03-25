#!/bin/bash

# Stop Jenkins service
sudo systemctl stop jenkins

# Disable Jenkins service from starting on boot
sudo systemctl disable jenkins

# Uninstall Jenkins
sudo yum remove -y jenkins

# Remove Jenkins repository
sudo rm -f /etc/yum.repos.d/jenkins.repo
sudo rpm -e --nodeps jenkins.io.key

# Uninstall Java
sudo yum remove -y java-11

# Clean package cache
sudo yum clean all

