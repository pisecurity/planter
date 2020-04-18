#!/bin/sh

update="/opt/planter `ls -d /opt/pisecurity/* 2>/dev/null`"

for PD in $update; do
	/opt/planter/git/pull.sh $PD

	if [ -x $PD/setup.sh ]; then
		$PD/setup.sh
	fi
done
