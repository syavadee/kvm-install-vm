#!/bin/bash
setenforce 0
sed -i /etc/selinux/config -e 's/^SELINUX=enforcing/SELINUX=disabled/'

sed -e '/^BOOTPROTO=\|^NETMASK=\|^IPADDR=\|^GATEWAY=\|^DNS1=/d' \
    -e'$aBOOTPROTO="none"' \
    -e '$aNETMASK=255.255.255.0' \
    -e '$aIPADDR=192.168.122.202' \
    -e '$aGATEWAY=192.168.122.1' \
    -e '$aDNS1=8.8.8.8' \
    -i /etc/sysconfig/network-scripts/ifcfg-eth0
systemctl restart NetworkManager.service

