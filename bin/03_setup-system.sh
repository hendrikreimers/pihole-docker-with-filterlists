#! /bin/bash

SCRIPTPATH=`cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P`
cd $SCRIPTPATH
cd ..

source $SCRIPTPATH/../templates/setup-docker-config.env

sysctl net.ipv6.conf.all.disable_ipv6=0
sysctl net.ipv6.conf.default.disable_ipv6=0

systemctl disable systemd-resolved.service
systemctl stop systemd-resolved

#cp /etc/resolv.conf /etc/resolv.conf.bak
#echo "nameserver 9.9.9.9" > /etc/resolv.conf

cp /etc/dhcpcd.conf /etc/dhcpcd.conf.bak
cat << EOT >> /etc/dhcpcd.conf

interface eth0
static ip_address=${IPV4}/24
static ip6_address=${IPV6}/64
static routers=${ROUTER_IPV4}
static domain_name_servers=9.9.9.9 149.112.112.112 2620:fe::fe 2620:fe::9

EOT

cat << EOT > /etc/docker/daemon.json
{
  "ipv6": true,
  "fixed-cidr-v6": "fd00::/80"
}
EOT
