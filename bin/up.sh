#! /bin/bash

SCRIPTPATH=`cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P`
cd $SCRIPTPATH
cd ..

docker compose up -d
docker exec -t pihole /bin/sh -c 'apt update && apt install -y wget'
docker exec -t pihole /bin/sh -c 'echo "0 3 2 * * root export URL_DOMAIN="172.18.0.3:8080/pihole-unique-filterlist-creator" && curl -sSLf http://172.18.0.3:8080/pihole-unique-filterlist-creator/dist/pihole-update-static-lists.sh | sed --expression='s/https:/http:/g' | bash" >> /etc/crontab'
