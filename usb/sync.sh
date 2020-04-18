#!/bin/sh
. /opt/planter/functions

DEVICE=$1
UUID=$2
TARGET=`/opt/pisecurity/planter-drives/utils/get-target-directory.sh`


log info "plugged $UUID (syncing to $TARGET)"

mv -f /run/planter-$DEVICE.info $TARGET/$UUID.info
rsync -av /media/$UUID $TARGET >>$TARGET/$UUID.log

sync
log info "plugged $UUID (sync finished)"
