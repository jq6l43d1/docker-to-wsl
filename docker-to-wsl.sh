#!/bin/bash

This script builds a docker image, runs a container from the image, and exports it.

# Clone the repo
git clone git@github.com:jq6l43d1/docker-to-wsl.git
cd docker-to-wsl || exit

# Build the image
docker build -t cloud-cli-os-image -f cloud-cli-os.Dockerfile .

# Run the container
docker run -dit --rm --name cloud-cli-os-container cloud-cli-os-image

# Export the container
docker export cloud-cli-os-container | bzip2 > cloud-cli-os-container.tar.bz2


