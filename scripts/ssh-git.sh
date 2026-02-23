#!/bin/bash

# ==========================================
# Script to Setup SSH and Git on Ubuntu Server
# ==========================================

# Exit on error
set -e

echo "Starting SSH and Git setup..."

# 1. Update system packages
echo "Updating system packages..."
sudo apt update -y
sudo apt upgrade -y

# 2. Install Git and OpenSSH if not installed
echo "Installing Git and OpenSSH..."
sudo apt install -y git openssh-client openssh-server

# 3. Configure SSH key
SSH_KEY="$HOME/.ssh/id_rsa"

if [ -f "$SSH_KEY" ]; then
    echo "SSH key already exists at $SSH_KEY"
else
    echo "Generating new SSH key..."
    read -p "Enter your email for SSH key: " user_email
    ssh-keygen -t rsa -b 4096 -C "$user_email" -f "$SSH_KEY" -N ""
    echo "SSH key generated at $SSH_KEY"
fi

# 4. Start and enable SSH service
echo "Starting and enabling SSH service..."
sudo systemctl enable ssh
sudo systemctl start ssh

# 5. Display public key
echo "Your public SSH key (add this to GitHub/GitLab/Bitbucket):"
cat "${SSH_KEY}.pub"

# 6. Configure Git
read -p "Do you want to configure Git user name and email? (y/n): " configure_git
if [[ "$configure_git" == "y" || "$configure_git" == "Y" ]]; then
    read -p "Enter Git user name: " git_name
    git config --global user.name "$git_name"
    read -p "Enter Git email: " git_email
    git config --global user.email "$git_email"
    echo "Git configured with:"
    git config --global --list
fi

# 7. Test SSH connection (optional)
read -p "Do you want to test SSH connection to GitHub? (y/n): " test_ssh
if [[ "$test_ssh" == "y" || "$test_ssh" == "Y" ]]; then
    echo "Testing SSH connection..."
    ssh -T git@github.com || echo "SSH test failed or GitHub requires you to accept fingerprint first."
fi

echo "SSH and Git setup completed!"
