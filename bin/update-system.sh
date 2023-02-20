#! /bin/bash

apt -y update
apt -y upgrade
apt -y dist-upgrade
apt -y autoremove --purge
apt -y autoclean
apt -y clean
