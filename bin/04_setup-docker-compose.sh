#! /bin/bash

SCRIPTPATH=`cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P`
source $SCRIPTPATH/../templates/setup-docker-config.env

# Read Password
echo -n "Password (pi.hole Admin): "
read -s PASSWORD

cat <<EOT > $SCRIPTPATH/../docker-compose.override.yml
services:
  pihole:
    hostname: "${HOSTNAME}"
    
    environment:
      FTLCONF_webserver_api_password: "${PASSWORD}"
      
      PROXY_LOCATION: "${HOSTNAME}" # Server Hostname
      VIRTUAL_HOST: "${HOSTNAME}" # Server Hostname
      
      #INTERFACE: "eth0"
      FTLCONF_LOCAL_IPV4: "${IPV4}" # Server IP
      FTLCONF_LOCAL_IPV6: "${IPV6}" # Server IP
      
      #REV_SERVER_CIDR: "${ROUTER_NET}/24" # Network
      #REV_SERVER_TARGET: "${ROUTER_IPV4}" # Router IP
      #REV_SERVER_DOMAIN: "${ROUTER_HOST}" # Router Hostname
      FTLCONF_dns_revServers: "true,${ROUTER_NET}/24,${ROUTER_IPV4}#53,${ROUTER_HOST}"
EOT