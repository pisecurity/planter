#!/bin/bash
. /opt/planter/functions

TARGET=`/opt/fajneit/planter-drives/utils/get-target-directory.sh`
DEVICES=`/opt/fajneit/camera-utils/utils/list-mtp-devices.sh`
for DEVICE in $DEVICES; do
	camera="${DEVICE%:*}"
	bus="${DEVICE##*:}"

	FILE=/run/usb-`echo $bus |tr ',' '-'`.mtp
	if [ -f $FILE ]; then continue; fi   # MTP port numbers are reused by system only after reboot or full bus cleanup, so it seems safe

	log info "plugged $camera (recognized as MTP storage)"
	if [ -f $TARGET/$camera.info ]; then continue; fi   # device already processed (at least started), resume next day

	show "mtp_device_detected"

	# this scans ALL connected MTP devices, not just this one
	mtp-detect 2>/dev/null >$FILE
	cp $FILE $TARGET/$camera.info

	# if at least one connected MTP devices has storage capability, process them all
	if grep -q StorageID $FILE; then
		mkdir -p /media/$camera
		jmtpfs -device=$bus /media/$camera

		show "user_rsync_started"
		log info "plugged $camera (syncing to $TARGET)"

		rsync -av \
			--exclude cache/ \
			--exclude .cache/ \
			--exclude .facebook_cache/ \
			--exclude debug_log/ \
			--exclude '*.mp3' \
			--exclude '*.MP3' \
			/media/$camera $TARGET >>$TARGET/$camera.log
		sync

		if [ "`find $TARGET/$camera -type f`" = "" ]; then
			log info "plugged $camera (apparently not agreed on file access yet, repeating scan)"
			mv -f $TARGET/$camera.log $TARGET/$camera.log.error
			mv -f $TARGET/$camera.info $TARGET/$camera.info.error
			rm -f $FILE
		fi

		log info "plugged $camera (sync finished)"
		show "user_operation_finished"

		log info "attempting to unmount /media/$camera"
		umount /media/$camera
	fi

	show "mtp_device_processed"
	sleep 2
done
