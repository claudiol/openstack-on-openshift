#!/bin/sh

cd /var/lib/libvirt/images
cp rhel-9.4-x86_64-kvm.qcow2 rhel9-guest.qcow2
qemu-img info rhel9-guest.qcow2
qemu-img resize rhel9-guest.qcow2 +90G
chown -R qemu:qemu rhel9-*.qcow2
virt-customize -a rhel9-guest.qcow2 --run-command 'growpart /dev/sda 4'
virt-customize -a rhel9-guest.qcow2 --run-command 'xfs_growfs /'
virt-customize -a rhel9-guest.qcow2 --root-password password:redhat
virt-customize -a rhel9-guest.qcow2 --run-command 'systemctl disable cloud-init'
virt-customize -a /var/lib/libvirt/images/rhel9-guest.qcow2 --ssh-inject root:file:/root/.ssh/id_rsa.pub
virt-customize -a /var/lib/libvirt/images/rhel9-guest.qcow2 --selinux-relabel
qemu-img create -f qcow2 -F qcow2 -b /var/lib/libvirt/images/rhel9-guest.qcow2 /var/lib/libvirt/images/osp-compute-0.qcow2
virt-install --virt-type kvm --ram 16384 --vcpus 4 --cpu=host-passthrough --os-variant rhel8.4 --disk path=/var/lib/libvirt/images/osp-compute-0.qcow2,device=disk,bus=virtio,format=qcow2 --network network:ocp4-provisioning --network network:ocp4-net --boot hd,network --noautoconsole --vnc --name osp-compute0 --noreboot
virsh start osp-compute0


virsh domifaddr osp-compute0 --source agent
