#! /bin/bash

SCRIPTPATH=`cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P`
cd $SCRIPTPATH
cd ..

# Check if running
RUNNING_PIHOLE=`docker container ls -f "name=pihole" -q`
RUNNING_PILISTS=`docker container ls -f "name=pihole-lists" -q`

if [ ! -z "$RUNNING_PILISTS" ] && [ ! -z "$RUNNING_PIHOLE" ]; then
    docker exec -t pihole-lists /bin/sh -c 'cd $list_path && git pull'
    docker exec -t pihole-lists /bin/sh -c '/bin/sh $list_path/run.sh'
    
    docker exec -t pihole /bin/sh -c 'wget http://172.18.0.3:8080/pihole-unique-filterlist-creator/dist/_whitelist.txt -O /etc/pihole/whitelist.txt -q > /dev/null'
    docker exec -t pihole /bin/sh -c 'PATH="$PATH:/usr/sbin:/usr/local/bin/" pihole updateGravity'
    docker exec -t pihole /bin/sh -c 'export URL_DOMAIN="172.18.0.3:8080/pihole-unique-filterlist-creator" && curl -sSLf http://172.18.0.3:8080/pihole-unique-filterlist-creator/dist/pihole-update-static-lists.sh | sed --expression='s/https:/http:/g' | bash'
else
    echo "System not running!"
fi
