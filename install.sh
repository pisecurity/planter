#!/bin/sh

mkdir -p /media/fallback

if [ -x /opt/farm/scripts/setup/extension.sh ]; then
	/opt/farm/scripts/setup/extension.sh sf-php
fi

if [ ! -d /opt/fajneit/blinkt-persistence ]; then
	git clone https://github.com/fajneit/blinkt-persistence /opt/fajneit/blinkt-persistence
fi

if [ ! -d /opt/fajneit/planter-drives ]; then
	git clone https://github.com/fajneit/planter-drives /opt/fajneit/planter-drives
fi

if [ ! -d /opt/fajneit/camera-utils ]; then
	git clone https://github.com/fajneit/camera-utils /opt/fajneit/camera-utils
fi

echo "downloading drive lists"
/opt/fajneit/planter-drives/setup.sh
/opt/fajneit/camera-utils/setup.sh

echo "copying usbmount templates"
cp -af /opt/planter/templates/usbmount@.service /etc/systemd/system
cp -af /opt/planter/templates/usbmount.rules /etc/udev/rules.d
ln -sf /opt/planter/events/shutdown.sh /etc/network/if-down.d/shutdown-blinkt
systemctl daemon-reload

if ! grep -q /opt/planter/cameras/process.sh /etc/crontab; then
	echo "setting up crontab entry for /opt/planter/cameras/process.sh"
	echo "* * * * * root /opt/planter/cameras/process.sh" >>/etc/crontab
fi


if [ ! -f /usr/lib/python3/dist-packages/blinkt.py ]; then
	echo "now execute as \"pi\" user and reboot:"
	echo "curl https://get.pimoroni.com/blinkt | bash"
else

	if ! grep -q /opt/planter/events/boot.sh /etc/rc.local; then
		echo "setting up rc.local entry"
		echo "\n\n# Move this line above \"exit 0\"" >>/etc/rc.local
		echo "/opt/planter/events/boot.sh" >>/etc/rc.local
		mcedit /etc/rc.local
	fi

	/opt/planter/events/boot.sh
fi
