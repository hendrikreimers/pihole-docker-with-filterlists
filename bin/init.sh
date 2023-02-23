#! /bin/bash

SCRIPTPATH=`cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P`
cd $SCRIPTPATH
cd ..

cd $SCRIPTPATH
./start.sh
./update-lists.sh

docker builder prune -af