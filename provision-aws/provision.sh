#!/bin/bash -e

CLUSTER_NAME=$1


export ANSIBLE_CONFIG=/vagrant/provision-aws/inventories/${CLUSTER_NAME}/ansible.cfg

ansible-playbook \
    --connection=ssh \
    --timeout=30 \
    playbooks/ansible-deps.yml

ansible-playbook \
    --connection=ssh \
    --timeout=30 \
    playbooks/setup-cluster-host.yml

ansible-playbook \
    --connection=ssh \
    --timeout=30 \
    playbooks/docker-install.yml

ansible-playbook \
    --connection=ssh \
    --timeout=30 \
    playbooks/k8s-install.yml

ansible-playbook \
    --connection=ssh \
    --timeout=30 \
    playbooks/deploy-apps.yml
