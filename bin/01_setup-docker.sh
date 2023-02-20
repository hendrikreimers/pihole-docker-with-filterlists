#! /bin/bash

SCRIPTPATH=`cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P`
cd $SCRIPTPATH
cd ..

apt -y update
apt -y upgrade
apt -y dist-upgrade
apt -y autoremove --purge
apt -y autoclean
apt -y clean

apt install -y apt-transport-https ca-certificates software-properties-common net-tools
curl -fsSL https://get.Docker.com -o get-Docker.sh
chmod +x get-Docker.sh
./get-Docker.sh

usermod -aG docker pi
docker version

rm ./get-Docker.sh
