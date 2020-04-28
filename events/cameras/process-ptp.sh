#!/bin/sh
. /opt/planter/functions

PORTS=`/opt/pisecurity/camera-utils/utils/list-ptp-ports.sh`
for PORT in $PORTS; do

	FILE=/run/`echo $PORT |tr ':,' '-'`.ptp
	if [ -f $FILE ]; then continue; fi   # PTP port numbers are reused by system only after reboot or full bus cleanup, so it seems safe

	camera=`/opt/pisecurity/camera-utils/utils/get-ptp-device-name.sh $PORT $FILE`
	if [ "$camera" = "" ]; then continue; fi   # PTP bus error, resume next script run, $FILE was deleted

	log info "plugged $camera (recognized as PTP storage)"
	TARGET=`/opt/pisecurity/planter-drives/utils/get-target-directory.sh`
	if [ -f $TARGET/$camera.info ]; then continue; fi   # device already processed (at least started), resume next day

	show "ptp_device_detected"
	show "user_rsync_started"

	mkdir -p $TARGET/$camera
	cd $TARGET/$camera

	log info "plugged $camera (downloading new files to $TARGET/$camera)"

	cp $FILE $TARGET/$camera.info
	/opt/pisecurity/camera-utils/utils/sync-ptp-device.sh $PORT $TARGET/$camera.log
	sync

	if [ ! -s $TARGET/$camera.log ] || grep -q '^For debugging messages' $TARGET/$camera.log; then
		log info "plugged $camera (apparently not agreed on file access yet, repeating scan)"
		mv -f $TARGET/$camera.log $TARGET/$camera.log.error
		mv -f $TARGET/$camera.info $TARGET/$camera.info.error
		rm -f $FILE
	fi

	log info "plugged $camera (sync finished)"

	show "user_operation_finished"
	show "ptp_device_processed"
	sleep 10
done
