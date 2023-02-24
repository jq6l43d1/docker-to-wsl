# This dockerfile builds an Ubuntu image with the latest versions of
# the CLI tools for Azure, AWS, and GCP.

# Start with the latest LTS Ubuntu image
FROM ubuntu:latest

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections


# Install prerequisites
RUN apt-get update && \
    apt-get install -y curl apt-transport-https lsb-release gnupg unzip && \
    rm -rf /var/lib/apt/lists/*

# Install the latest versions of the Azure CLI, AWS CLI, and GCP SDK

# Install the Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install the AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf *

# Install the GCP CLI
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | \
    tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | tee /usr/share/keyrings/cloud.google.gpg && \
    apt-get update && \
    apt-get install -y google-cloud-cli && \
    rm -rf /var/lib/apt/lists/*
    
# Add testuser user
RUN adduser --disabled-password --gecos '' testuser && \
    passwd -d testuser && \
    usermod -aG sudo testuser && \
    echo "testuser ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
