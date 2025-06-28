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
    alpine:3.16 sh
done

for node in node1 node2 node3; do
  echo "Setting working Alpine mirror in $node..."
  docker exec $node sh -c "echo 'http://dl-cdn.alpinelinux.org/alpine/v3.16/main' > /etc/apk/repositories"
  docker exec $node sh -c "echo 'http://dl-cdn.alpinelinux.org/alpine/v3.16/community' >> /etc/apk/repositories"
  docker exec $node apk update
  docker exec $node apk add --no-cache openssh python3 curl nano busybox lighttpd
  docker exec $node ssh-keygen -A
  docker exec $node /usr/sbin/sshd
  docker exec -i $node sh -c "mkdir -p /root/.ssh && chmod 700 /root/.ssh"
  cat ~/.ssh/id_rsa_ansible.pub | docker exec -i $node sh -c "cat >> /root/.ssh/authorized_keys"
  docker exec -i $node sh -c "chmod 600 /root/.ssh/authorized_keys"
done

echo "Environment ready. Use 'make ping' or 'make playbook'"
