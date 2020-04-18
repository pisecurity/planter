#!/bin/bash
. /opt/planter/functions

FILESYSTEMS="ext2 ext3 ext4 hfsplus vfat exfat ntfs"

BASE=`basename $DEVNAME`
DEVICE=/$DEVNAME

lock "planter-usb-$BASE"
show "progress"

tmp=`/opt/pisecurity/camera-utils/utils/get-usb-device-uuid.sh $DEVICE /run/planter-$BASE.info`

if [ "$tmp" = "" ]; then
	log info "$DEVICE does not contain a filesystem or disklabel, or cannot be identified"
	exit 1
fi

UUID="${tmp%:*}"
FSTYPE="${tmp##*:}"

if egrep -q "^[[:blank:]]*$DEVICE" /etc/fstab; then
	log info "executing command: mount $DEVICE"
	mount $DEVICE || log err "mount by DEVNAME with $DEVICE wasn't successful; return code $?"

elif egrep -q "^[[:blank:]]*UUID=$UUID" /etc/fstab; then
	log info "executing command: mount -U $UUID"
	mount -U $UUID || log err "mount by UUID with $UUID wasn't successful; return code $?"

else
	log info "$DEVICE contains filesystem type $FSTYPE"

	fstype=$FSTYPE
	if in_list "$fstype" "$FILESYSTEMS"; then
		if ! grep -q /media/$UUID /proc/mounts; then

			log info "mounting $DEVICE at /media/$UUID"
			ret=`/opt/pisecurity/planter-drives/utils/add-drive.sh $DEVICE $fstype $UUID /media/$UUID`

			if [ "$ret" != "error" ]; then
				/opt/planter/usb/dispatch.sh $DEVICE $UUID $ret
			fi
		fi
	fi
fi

show "ready"
log info "planter execution finished"
