#! /bin/bash

SCRIPTPATH=`cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P`

# Disable USB Chip (Ports)
#echo '1-1' | tee /sys/bus/usb/drivers/usb/unbind

# Turn off HDMI
tvservice -o

echo "@reboot tvservice -o" >> /etc/crontab
echo "" >> /etc/crontab

# Disable Bluetooth and WiFi
cat <<EOT > /boot/config.txt
dtoverlay=pi3-disable-wifi
dtoverlay=pi3-disable-bt
EOT

# Disable on-board LEDs
cat <<EOT > /boot/config.txt
dtparam=act_led_trigger=none
dtparam=act_led_activelow=on
EOT

echo ""
echo ">>> Reboot to enable this features!"
