#! /bin/bash

SCRIPTPATH=`cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P`
SELF="${SCRIPTPATH}/$(basename $0)"

#raspi-config --expand-rootfs

chmod +x $SCRIPTPATH/bin/*.sh

./bin/01_setup-docker.sh
./bin/02_setup-docker-config.sh
./bin/03_setup-system.sh
./bin/04_setup-docker-compose.sh
./bin/05_pi-save-energy.sh
./bin/reset.sh

chmod -x $SELF

echo ""
echo ">>> Reboot now and after that login by SSH and run '${SCRIPTPATH}/bin/init.sh' as root"
echo ""