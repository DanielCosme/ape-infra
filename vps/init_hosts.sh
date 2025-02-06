#! /usr/bin/env sh

MACHINES=$(realpath machines.txt)
echo $MACHINES

while read IP FQDN HOST; do
   CMD="sed -i 's/^127.0.1.1.*/127.0.1.1\t${FQDN} ${HOST}/' /etc/hosts"
   ssh -n root@${IP} "$CMD"
   ssh -n root@${IP} hostnamectl hostname ${HOST}
   ssh -n root@${IP} hostname --fqdn
done < "$MACHINES"

rm hosts
touch hosts
echo "" > hosts
echo "# Ape Infra" >> hosts
while read IP FQDN HOST; do 
    ENTRY="${IP} ${FQDN} ${HOST}"
    echo $ENTRY >> hosts
    scp hosts root@${IP}:~/
    ssh -n \
        root@${IP} "cat hosts >> /etc/hosts"
done < "$MACHINES"

