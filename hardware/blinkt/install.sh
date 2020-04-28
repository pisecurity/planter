#!/bin/sh

if [ ! -f /etc/rpi-issue ]; then
	# Blinkt is supported only on Raspberry Pi with Raspbian
	exit 0
fi


if [ ! -f /usr/lib/python3/dist-packages/blinkt.py ]; then
	echo "now execute as \"pi\" user and reboot:"
	echo "curl https://get.pimoroni.com/blinkt | bash"
else
	/opt/planter/git/clone.sh blinkt-persistence
fi
