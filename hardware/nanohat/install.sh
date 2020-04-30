#!/bin/sh

if [ ! -f /etc/friendlyelec-release ]; then
	# BakeBit NanoHat OLED is supported only on NanoPi-NEO2 platform.
	exit 0
fi

/opt/planter/git/clone.sh bakebit-nanohat-driver
