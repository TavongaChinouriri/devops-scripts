#!/bin/bash

# ==========================================
# Script to Install Ansible on Ubuntu Server
# ==========================================

# Exit on any error
set -e

echo "Starting Ansible installation on Ubuntu..."

# 1. Update system packages
echo "Updating system packages..."
sudo apt update -y
sudo apt upgrade -y

# 2. Install software-properties-common (for add-apt-repository)
echo "Installing prerequisites..."
sudo apt install -y software-properties-common

# 3. Add Ansible PPA
echo "Adding Ansible PPA..."
sudo add-apt-repository --yes --update ppa:ansible/ansible

# 4. Install Ansible
echo "Installing Ansible..."
sudo apt update -y
sudo apt install -y ansible

# 5. Verify installation
echo "Verifying Ansible installation..."
ansible --version

# Optional: Install ansible-lint
read -p "Do you want to install ansible-lint? (y/n): " install_lint
if [[ "$install_lint" == "y" || "$install_lint" == "Y" ]]; then
    sudo apt install -y python3-pip
    pip3 install --user ansible-lint
    echo "ansible-lint installed successfully."
fi

# Optional: Setup Python virtual environment for Ansible
read -p "Do you want to setup a Python virtual environment for Ansible? (y/n): " setup_venv
if [[ "$setup_venv" == "y" || "$setup_venv" == "Y" ]]; then
    sudo apt install -y python3-venv
    python3 -m venv ~/ansible-venv
    echo "Virtual environment created at ~/ansible-venv"
    echo "To activate it, run: source ~/ansible-venv/bin/activate"
fi

echo "Ansible installation completed successfully!"
