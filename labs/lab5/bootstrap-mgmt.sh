#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

sudo apt-get update
sudo apt-get -y upgrade

# install tools for managing ppa repositories
sudo apt-get -y install software-properties-common
sudo apt-get -y install unzip
sudo apt-get -y install build-essential
# 
sudo apt-get -y install libssl-dev 
sudo apt-get -y install libffi-dev 
# required for Openstack SDK
sudo apt-get -y install python3-dev 
sudo apt-get -y install python3-pip

# Add graph builder tool for Terraform
sudo apt-get -y install graphviz

# install Ansible (http://docs.ansible.com/intro_installation.html)
sudo apt-add-repository -y -u ppa:ansible/ansible
sudo apt-get update
sudo apt-get -y install ansible

# Install Terraform
sudo apt-get update
# install GNU Privacy Guard
sudo apt-get install -y gnupg
# add HashiCorp GPG key
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update
sudo apt-get -y install terraform

# install OpenStack SDK modules
pip install python-openstackclient

# Install Google Cloud SDK
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update
sudo apt-get -y install google-cloud-sdk

# Install Kubernetes Controller and Google Cloud SDK plugin (https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl#install_plugin)
sudo apt-get -y install kubectl google-cloud-sdk-gke-gcloud-auth-plugin

# Install Amazon AWS-CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Clean up cached packages
sudo apt-get clean all
sudo rm ./awscliv2.zip

