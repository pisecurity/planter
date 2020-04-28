#!/bin/sh
. /opt/planter/functions

lock "planter-cameras-cron"
show "progress"

/opt/planter/events/cameras/process-mtp.sh
/opt/planter/events/cameras/process-ptp.sh

show "ready"
