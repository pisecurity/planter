#!/bin/sh
. /opt/planter/functions

DEVICE=/$DEVNAME
ret=`/opt/pisecurity/planter-drives/utils/remove-drive.sh $DEVICE`

case "$ret" in
	ignore)
		log info "unplugged $DEVICE (ignoring)"
		;;
	target)
		log info "unplugged $DEVICE (reverting to fallback storage at /media/fallback)"
		show "target_drive_disconnected"
		;;
	source)
		log info "unplugged $DEVICE (plant source drive)"
		show "source_drive_disconnected"
		;;
	*)
		log info "unplugged $DEVICE (seized drive)"
		show "user_drive_disconnected"
		show "target_drive_error_clear"
		;;
esac
