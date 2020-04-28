#!/bin/sh
. /opt/planter/functions

DEVICE=$1
UUID=$2
RET=$3

case "$RET" in
	ignore)
		log info "plugged $UUID (ignoring)"
		;;
	target)
		log info "plugged $UUID (mounted as evidence storage)"
		# show "target_drive_progress"
		# in paid version, trigger checking free space under /media/$UUID
		show "target_drive_ready"
		;;
	source)
		log info "plugged $UUID (mounted as plant source drive)"
		show "source_drive_ready"
		;;
	*)
		# this is a seized drive (obtained from suspect, or 3rd person in general)
		log info "plugged $UUID (mounted as seized storage at /media/$UUID)"
		show "user_drive_mounted"

		if [ -d /media/source ]; then
			# in paid version, check if underlying filesystem is writable (may be
			# mounted read-write, but still be read-only, eg. old PQI pen drives with
			# write protection switch); trigger "user_operation_error"
			# event and abort planting otherwise
			show "user_planting_started"
			/opt/planter/events/usb/plant.sh "$DEVICE" "$UUID"
		else
			# in paid version, trigger checking used space (counting number of used
			# sectors, not just nominal file size, to make sure that everything will
			# fit on target storage; trigger "target_drive_error_not_enough_space"
			# event otherwise)
			#
			# and don't just start sync.sh separately for each mounted drive - instead,
			# just push a connect event to the next layer, which runs a single combined
			# rsync for all connected logical partitions (way more efficient and stable)
			show "user_rsync_started"
			/opt/planter/events/usb/sync.sh "`basename $DEVICE`" "$UUID"
		fi

		show "user_operation_finished"
		;;
esac
