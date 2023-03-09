#! /bin/bash

SCRIPTPATH=`cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P`
cd $SCRIPTPATH
cd ..

docker compose down
docker image rm pihole/pihole
docker image rm hendrikreimers/pihole-lists

rm -Rf $SCRIPTPATH/../etc-dnsmasq.d/*
rm -Rf $SCRIPTPATH/../etc-pihole/*
rm -Rf $SCRIPTPATH/../logs-list/*
rm -Rf $SCRIPTPATH/../logs-pihole/*

cp $SCRIPTPATH/../templates/etc-pihole/* $SCRIPTPATH/../etc-pihole/
cp $SCRIPTPATH/../templates/etc-dnsmasq.d/* $SCRIPTPATH/../etc-dnsmasq.d/

DIR="$SCRIPTPATH/../_custom"
if [ -d "$DIR" ]; then
  cp -Rf $SCRIPTPATH/../_custom/* $SCRIPTPATH/../
fi

docker system prune -af
docker builder prune -af
