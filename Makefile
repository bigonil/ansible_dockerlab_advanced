.PHONY: up clean ping playbook

up:
 bash bootstrap.sh

ping:
 ansible myhosts -i inventory.ini -m ping

playbook:
 ansible-playbook -i inventory.ini site.yml

clean:
 docker rm -f node1 node2 node3 || true
 docker network rm tutorial_ansible_net || true
