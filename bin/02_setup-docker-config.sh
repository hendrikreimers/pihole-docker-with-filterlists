#! /bin/bash

SCRIPTPATH=`cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P`
source $SCRIPTPATH/../templates/setup-docker-config.env

read -e -p "System IPv4 Address: " -i $IPV4 IPV4
read -e -p "System IPv6 Address: " -i $IPV6 IPV6
read -e -p "System Hostname: " -i $HOSTNAME HOSTNAME
read -e -p "Network Address: " -i $ROUTER_NET ROUTER_NET
read -e -p "Router IPv4: " -i $ROUTER_IPV4 ROUTER_IPV4
read -e -p "Router IPv6: " -i $ROUTER_IPV6 ROUTER_IPV6
read -e -p "Router Hostname: " -i $ROUTER_HOST ROUTER_HOST

cat << EOT > $SCRIPTPATH/../templates/setup-docker-config.env
#! /bin/bash
IPV4='${IPV4}'
IPV6='${IPV6}'
HOSTNAME='${HOSTNAME}'
ROUTER_NET='${ROUTER_NET}'
ROUTER_IPV4='${ROUTER_IPV4}'
ROUTER_IPV6='${ROUTER_IPV6}'
ROUTER_HOST='${ROUTER_HOST}'
EOT