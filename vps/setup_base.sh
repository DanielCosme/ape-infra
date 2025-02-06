#! /usr/bin/env bash

MACHINES=$(realpath machines.txt)
echo $MACHINES

source $(realpath settings.sh)
echo $USER
TZ="America/New_York"
echo $TZ

while read IP FQDN HOST; do
    ssh -n root@${IP} "apt update -y && apt upgrade -y && apt install -y fish vim curl wget ufw"
    ssh -n root@${IP} "timedatectl set-timezone $TZ"
    ssh -n root@${IP} "adduser $USER && usermod -aG sudo $USER && echo $USER:$VM_PASSWORD | chpasswd && mkdir /home/$USER/.ssh"
    ssh -n root@${IP} "cp ~/.ssh/authorized_keys /home/$USER/.ssh/authorized_keys && chown -R $USER:$USER /home/$USER/.ssh"
    ssh -n root@${IP} "curl -s https://install.crowdsec.net | sudo sh && apt install -y crowdsec crowdsec-firewall-bouncer-iptables"
    scp sshd_config root@${IP}:/etc/ssh/sshd_config
    ssh -n root@${IP} "ufw allow OpenSSH && ufw --force enable"
    ssh -n root@${IP} "systemctl reload ssh && reboot"
done < "$MACHINES"

# sudo systemctl reload ss
