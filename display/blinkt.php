#!/usr/bin/php
<?php

// this can be adjusted to weather (estimated using timezone and current time, or even
// checked online if possible), Raspberry Pi case type, camouflage, and user's preference
$brightness = 1;


$cache = "/run/blinkt.json";
$cmd = "/opt/pisecurity/blinkt-persistence/v1/set-pixel-rgb.py";

$colors = array (
	"off"    => array(  0,   0,   0),
	"red"    => array(255,   0,   0),
	"green"  => array(  0, 255,   0),
	"blue"   => array(  0,   0, 255),
	"orange" => array(255,  30,   0),
	"yellow" => array(255,  70,   0),
	"purple" => array(255,   0, 255),
	"white"  => array(255, 255, 255),
);

$events = array (
	"ready"                                    => array(0, "yellow"),
	"progress"                                 => array(0, "off"),
	"shutdown"                                 => array(-1, "off"),

	"target_drive_progress"                    => array(1, "orange"),  // checking eg. free space in progress
	"target_drive_ready"                       => array(1, "green"),
	"target_drive_disconnected"                => array(1, "off"),

	"target_drive_error_not_enough_space"      => array(2, "purple"),  // not enough to copy everything, but still usable
	"target_drive_error_not_usable"            => array(2, "red"),     // no directories, disk full etc. - replace immediately
	"target_drive_error_clear"                 => array(2, "off"),

	"source_drive_ready"                       => array(3, "green"),
	"source_drive_disconnected"                => array(3, "off"),

	"user_drive_mounted"                       => array(4, "green"),
	"user_drive_disconnected"                  => array(4, "off"),

	"ptp_device_detected"                      => array(5, "yellow"),
	"ptp_device_processed"                     => array(5, "off"),

	"mtp_device_detected"                      => array(5, "green"),
	"mtp_device_processed"                     => array(5, "off"),

	"user_rsync_started"                       => array(7, "orange"),
	"user_planting_started"                    => array(7, "purple"),
	"user_operation_error"                     => array(7, "red"),
	"user_operation_finished"                  => array(7, "off"),
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
$pixel = $details[0];
list($r, $g, $b) = $colors[$details[1]];

if ($pixel != -1)
	execute("$cmd $cache $pixel $brightness $r $g $b");
else
	for ($pixel = 0; $pixel <= 7; $pixel++)
		execute("$cmd $cache $pixel $brightness $r $g $b");
