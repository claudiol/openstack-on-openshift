#!/bin/sh

sudo -i
scp /root/.ssh/id_rsa root@192.168.123.100:/root/.ssh/id_rsa_compute
scp /root/.ssh/id_rsa.pub root@192.168.123.100:/root/.ssh/id_rsa_compute.pub
