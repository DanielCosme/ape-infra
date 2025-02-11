#! /usr/bin/env bash

MACHINES=$(realpath machines.txt)
echo $MACHINES

source $(realpath settings.sh)
echo $VM_USER

while read IP FQDN HOST; do
    ssh -n $VM_USER@${HOST} "echo $VM_PASSWORD | chsh -s $(which fish)"
    scp ./config/fish/fish_user_key_bindings.fish $VM_USER@${HOST}:~/.config/fish/functions/fish_user_key_bindings.fish
    scp ./config/fish/config.fish $VM_USER@${HOST}:~/.config/fish/config.fish
done < "$MACHINES"

