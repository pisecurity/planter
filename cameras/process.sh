#!/bin/sh
. /opt/planter/functions

lock "planter-cameras-cron"
show "progress"

/opt/planter/cameras/process-mtp.sh
/opt/planter/cameras/process-ptp.sh

show "ready"
