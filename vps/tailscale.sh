#! /usr/bin/env bash

MACHINES=$(realpath machines.txt)
echo $MACHINES

source $(realpath settings.sh)
echo $VM_ADMIN

while read IP FQDN HOST; do
    ssh -n $VM_ADMIN@${IP} "curl -fsSL https://pkgs.tailscale.com/stable/debian/bookworm.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null"
    ssh -n $VM_ADMIN@${IP} "curl -fsSL https://pkgs.tailscale.com/stable/debian/bookworm.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list"
    ssh -n $VM_ADMIN@${IP} "sudo apt-get update -y && sudo apt-get install -y tailscale"
done < "$MACHINES"
