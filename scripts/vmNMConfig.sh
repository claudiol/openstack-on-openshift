#!/bin/sh


nmcli co delete 'Wired connection 1'
nmcli con add con-name "static-eth0" ifname eth0 type ethernet ip4 172.22.0.100/24 ipv4.dns "172.22.0.89"
nmcli con up "static-eth0"
nmcli co delete 'Wired connection 2'
nmcli con add con-name "static-eth1" ifname eth1 type ethernet ip4 192.168.123.61/24 ipv4.dns "192.168.123.100" ipv4.gateway "192.168.123.1"
nmcli con up "static-eth1"
