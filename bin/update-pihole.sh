#! /bin/bash

SCRIPTPATH=`cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P`
cd $SCRIPTPATH
cd ..

docker compose down
docker pull pihole/pihole
$SCRIPTPATH/start.sh