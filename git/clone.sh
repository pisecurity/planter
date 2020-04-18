#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <name>"
	exit 1
fi

name=$1
repo="https://github.com/pisecurity/$name"
path="/opt/pisecurity/$name"

if [ ! -d $path ]; then
	git clone $repo $path
elif [ ! -d $path/.git ] && [ ! -d $path/.svn ]; then
	echo "directory $path busy, skipping $name installation"
else
	/opt/planter/git/pull.sh $path
fi

if [ -x $path/setup.sh ]; then
	$path/setup.sh
fi
