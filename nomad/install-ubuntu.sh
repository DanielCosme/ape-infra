#!/usr/bin/env bash

echo "Installing the required packages"
sudo apt-get update && \
  sudo apt-get install wget gpg coreutils

echo "Adding hashicorp GPG key"
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "Adding the official HashiCorp Linux repository"
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main"  \
    | sudo tee /etc/apt/sources.list.d/hashicorp.list

echo "Updating and installing"
sudo apt-get update && sudo apt-get install nomad

echo "Installing CNI plugins"
curl -L -o cni-plugins.tgz "https://github.com/containernetworking/plugins/releases/download/v1.5.0/cni-plugins-linux-$( [ $(uname -m) = aarch64 ] && echo arm64 || echo amd64)"-v1.5.0.tgz && \
  sudo mkdir -p /opt/cni/bin && \
  sudo tar -C /opt/cni/bin -xzf cni-plugins.tgz
