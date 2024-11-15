#!/bin/sh

HOSTNAME=$(hostname)

if [[ $HOSTNAME != *"ocp4-bastion"* ]]; then
  echo "You need to be in the bastion host!"
  exit
fi

mkdir -p /nfs/cinder
chmod 777 /nfs/cinder
mkdir -p /nfs/glance
chmod 777 /nfs/glance
