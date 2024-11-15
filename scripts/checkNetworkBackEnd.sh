#!/bin/sh



echo "If your cluster is RHOCP 4.14 or later and it has OVNKubernetes as the network back end, then you must enable global forwarding so that MetalLB can work on a secondary network interface.

Check the network back end used by your cluster:"
NETWORK=$(oc get network.operator cluster --output=jsonpath='{.spec.defaultNetwork.type}')
if [ $? != 0 ]; then
  exit
fi

if [ "$NETWORK" == "OVNKubernetes" ]; then
  oc patch network.operator cluster -p '{"spec":{"defaultNetwork":{"ovnKubernetesConfig":{"gatewayConfig":{"ipForwarding": "Global"}}}}}' --type=merge

  if [ $? != 0 ]; then
    exit
  fi
fi

echo "NodeNetworkConfigurationPolicy (nncp) resource is used to configure RHOSO openstack services network isolation:"
oc get nncp
if [ $? != 0 ]; then
  exit
fi

echo "You can describe the NodeNetworkConfigurationPolicy applied in worker using osp-enp1s0-worker-ocp4-worker1:"
oc describe nncp osp-enp1s0-worker-ocp4-worker1

if [ $? != 0 ]; then
  exit
fi

echo "Review the NetworkAttachmentDefinition (nad) resources for each isolated network to attach a service pod to the corresponding network:"
oc get Network-Attachment-Definitions -n openstack

echo "Review the internalapi nad IP addressing configuration:"
oc describe Network-Attachment-Definitions internalapi -n openstack

echo "Review the MetalLB IP address range. You use the MetalLB Operator to expose internal service endpoints on the isolated networks. By default, the public service endpoints are exposed as RHOCP routes.:"
oc get IPAddressPools -n metallb-system

echo "Review the L2Advertisement resource which will define which node advertises a service to the local network which has been preconfigured for your demo environment:"
oc get L2Advertisements -n metallb-system

echo "Finally, review the data plane network. A NetConfig custom resource (CR) is used to configure all the subnets for the data plane networks. You must define at least one control plane network for your data plane. You can also define VLAN networks to create network isolation for composable networks, such as InternalAPI, Storage, and External. Each network definition must include the IP address assignment:"
oc get netconfigs -n openstack

echo "========="
oc describe netconfig openstacknetconfig -n openstack

