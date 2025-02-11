#! /usr/bin/env bash

MACHINES=$(realpath machines.txt)
echo $MACHINES

source $(realpath settings.sh)
echo $VM_ADMIN

while read IP FQDN HOST; do
    # ssh -n $VM_ADMIN@${IP} "sudo curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg"
    # ssh -n $VM_ADMIN@${IP} "sudo curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list"
    # ssh -n $VM_ADMIN@${IP} "sudo apt update -y && sudo apt install -y caddy && sudo systemctl status caddy"
    # ssh -n $VM_ADMIN@${IP} "sudo ufw allow proto tcp from any to any port 80,443 && sudo ufw status"
    scp ./config/caddy/Caddyfile $VM_ADMIN@${IP}:~/Caddyfile
    ssh -n $VM_ADMIN@${IP} "sudo mv ~/Caddyfile /etc/caddy/Caddyfile && sudo systemctl restart caddy"
done < "$MACHINES"

