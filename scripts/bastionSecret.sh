#!/bin/sh

oc create secret generic dataplane-ansible-ssh-private-key-secret --save-config --dry-run=client --from-file=authorized_keys=/root/.ssh/id_rsa_compute.pub --from-file=ssh-privatekey=/root/.ssh/id_rsa_compute --from-file=ssh-publickey=/root/.ssh/id_rsa_compute.pub -n openstack -o yaml | oc apply -f-
