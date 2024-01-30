#! /usr/bin/env bash
# install-vscode-ubuntu.sh

sudo apt-get update -y

sudo apt-get install -y \
    snapd
sudo snap install --classic \
    code
