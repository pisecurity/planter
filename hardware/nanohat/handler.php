#!/usr/bin/php
<?php

$clear = "/opt/pisecurity/bakebit-nanohat-driver/oled/clear.py";
$print = "/opt/pisecurity/bakebit-nanohat-driver/oled/line.py";

$events = array (
	"ready"                                    => array(0, "ready"),
	"progress"                                 => array(0, "..."),
	"shutdown"                                 => array(-1, false),

	"target_drive_progress"                    => array(1, "checking target"),  // checking eg. free space in progress
	"target_drive_ready"                       => array(1, "target ready"),
	"target_drive_disconnected"                => array(1, false),

	"target_drive_error_not_enough_space"      => array(2, "not enough space"),  // not enough to copy everything, but still usable
	"target_drive_error_not_usable"            => array(2, "not usable"),        // no directories, disk full etc. - replace immediately
	"target_drive_error_clear"                 => array(2, false),

	"source_drive_ready"                       => array(3, "source ready"),
	"source_drive_disconnected"                => array(3, false),

	"user_drive_mounted"                       => array(4, "user drive mnt"),
	"user_drive_disconnected"                  => array(4, false),

	"ptp_device_detected"                      => array(5, "ptp detected"),
	"ptp_device_processed"                     => array(5, false),

	"mtp_device_detected"                      => array(5, "mtp detected"),
	"mtp_device_processed"                     => array(5, false),

	"user_rsync_started"                       => array(7, "rsyncing data"),
	"user_planting_started"                    => array(7, "planting"),
	"user_operation_error"                     => array(7, "error during sync"),
	"user_operation_finished"                  => array(7, false),
);


function execute($exec) {
	$out = shell_exec($exec);
	if (!empty($out))
		echo trim($out)." [$exec]\n";
}


if ($argc < 2)
	die("usage: $argv[0] <event>\n");

$event = $argv[1];

if (!isset($events[$event]))
	die("error: unknown event \"$event\"\n");

$details = $events[$event];
$line = $details[0]+1;
$text = $details[1];

if ($line == -1)
	execute("$clear");
else {
	if ($text == "ready")
		execute("$clear");
	else if ($text === false)
		$text = "";
	execute("$print $line \"$text\"");
}
