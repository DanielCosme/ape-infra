#! /usr/bin/env bash

MACHINES=$(realpath machines.txt)
echo $MACHINES

source $(realpath settings.sh)
echo "User: $VM_ADMIN"

while read IP FQDN HOST; do
    ssh -n $VM_ADMIN@${IP} "sudo useradd -U --create-home syncthing"
    ssh -n $VM_ADMIN@${IP} "sudo mkdir -p /etc/apt/keyrings"
    ssh -n $VM_ADMIN@${IP} "sudo curl -L -o /etc/apt/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg"
    ssh -n $VM_ADMIN@${IP} "echo "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list"
    ssh -n $VM_ADMIN@${IP} "sudo apt-get update -y"
    ssh -n $VM_ADMIN@${IP} "sudo apt-get install -y syncthing"
    ssh -n $VM_ADMIN@${IP} "sudo systemctl enable --now syncthing@syncthing.service"
    ssh -n $VM_ADMIN@${IP} "sudo systemctl status syncthing@syncthing.service"
done < "$MACHINES"

