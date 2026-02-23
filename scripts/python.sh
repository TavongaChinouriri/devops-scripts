#!/bin/bash

# ==========================================
# Python Installation Script for Ubuntu Server
# Installs Python 3.12 safely alongside system Python
# ==========================================

set -e

echo "Updating system..."
sudo apt update -y
sudo apt upgrade -y

echo "Installing prerequisites..."
sudo apt install -y software-properties-common curl wget git build-essential

echo "Adding deadsnakes PPA (for newer Python versions)..."
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt update -y

echo "Installing Python 3.12 and development tools..."
sudo apt install -y \
    python3.12 \
    python3.12-venv \
    python3.12-dev \
    python3.12-distutils \
    python3-pip

echo "Verifying Python installation..."
python3.12 --version

echo "Upgrading pip for Python 3.12..."
python3.12 -m ensurepip --upgrade
python3.12 -m pip install --upgrade pip setuptools wheel

# Optional virtual environment
read -p "Create default virtual environment at ~/py312-venv? (y/n): " create_venv
if [[ "$create_venv" == "y" || "$create_venv" == "Y" ]]; then
    python3.12 -m venv ~/py312-venv
    echo "Virtual environment created at ~/py312-venv"
    echo "Activate with: source ~/py312-venv/bin/activate"
fi

echo "Python 3.12 installation completed successfully."
