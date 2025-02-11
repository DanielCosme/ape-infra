#! /usr/bin/env bash

MACHINES=$(realpath machines.txt)
echo $MACHINES

source $(realpath settings.sh)
echo $VM_ADMIN

while read IP FQDN HOST; do
    ssh -n $VM_ADMIN@${IP} "sudo apt-get -y update && sudo apt-get install -y ca-certificates curl && sudo install -m 0755 -d /etc/apt/keyrings && sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && sudo chmod a+r /etc/apt/keyrings/docker.asc"
    ssh -n $VM_ADMIN@${IP} 'echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null'
    ssh -n $VM_ADMIN@${IP} "sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
    ssh -n $VM_ADMIN@${IP} "sudo groupadd docker"
    ssh -n $VM_ADMIN@${IP} "sudo usermod -aG docker $VM_USER && sudo newgrp docker"
    ssh -n $VM_ADMIN@${IP} "sudo systemctl enable docker.service && sudo systemctl enable containerd.service"
done < "$MACHINES"
