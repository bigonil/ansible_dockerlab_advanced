#!/bin/bash
set -e

docker network create --driver bridge \
  --subnet 192.0.2.0/24 --gateway 192.0.2.1 \
  --opt com.docker.network.bridge.name=bridge01 \
  tutorial_ansible_net || true

for i in 1 2 3; do
  docker rm -f node$i || true
  docker run -dit \
    --name node$i \
    --net tutorial_ansible_net \
    --ip 192.0.2.5$i \
    -p 225$i:22 \
    -p 808$i:80 \
    alpine sh
done

for node in node1 node2 node3; do
  docker exec $node apk add --no-cache openssh python3 busybox-suid curl nano
  docker exec $node ssh-keygen -A
  docker exec $node /usr/sbin/sshd
  docker exec $node mkdir -p /root/.ssh
  docker exec $node sh -c "echo '$(cat ~/.ssh/id_rsa_ansible.pub)' >> /root/.ssh/authorized_keys"
  docker exec $node chmod 600 /root/.ssh/authorized_keys
done

echo "Environment ready. Use 'make ping' or 'make playbook'"
