#! /usr/bin/env bash
# install-docker-fedora.sh

# https://docs.docker.com/engine/install/fedora/
# Set up the repository
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

# Install Docker Engine
sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable and start Docker
sudo systemctl enable docker
sudo systemctl start docker

# Create docker group and add current user to it
# sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# Verify
docker run hello-world
