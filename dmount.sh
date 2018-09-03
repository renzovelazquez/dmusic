#!/bin/bash
# Simple program to mount a device's file system to a specific folder
# This is useful for external storage devices, fash usb, CD-ROMS, etc.

# usage: dmount DEVICE MOUNT_PATH

DEVICE=$1
DEST=$2
if [ -z "$DEVICE" ] && [ -z "$DEST" ]; then
	echo "Use this script as follows: dmount DEVICE MOUNT_PATH"
	exit 2
fi

CHECK_DEV=$(ls /dev/ | grep -x $DEVICE)

mount_device()
{
	mount --verbose "/dev/$DEVICE" $DEST
}

if [ "$DEVICE" = "$CHECK_DEV" ]; then

	if [ 4 -ne ${#DEVICE} ]; then
		echo "You must specify the partition you're trying to mount on. example: sda1, sdb1."
		echo "Do not pass sda, sdb, sd* alone because that's not allowed"
		exit 2
	fi

	if ! [ -d "$DEST" ]; then
		echo "The destination is not a directory or doesn't exist. ($DEST)"
		echo "exit."
		exit 2
	fi

	if [ -w "$DEST" ] && [ -x "$DEST" ] && [ -r "$DEST" ]; then
		mount_device
	else
		echo "You don't have permission to read, write or excecute in $DEST. Run it as sudo"
		echo "exit"
		exit 2
	fi
else
	echo "/dev/$DEVICE does not exist"
	echo "Here are all the devices that are available: "
	ls /dev/ | grep "sd"
	exit 2
fi
echo "All OK. Your file system has mounted successfully on:"
echo "$DEST"
exit 0
