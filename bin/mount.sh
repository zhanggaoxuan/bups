#!/usr/bin/env bash

BACKUP_DIRS=("/home/laureantoine/Documents")
HOST="livebox"
SHARE="backups"
OPTIONS="guest"
MOUNT_PATH="mnt"
ENABLE_NOTIFY=0
ENABLE_UI=1
SUDO_CMD=sudo

# See https://wiki.archlinux.org/index.php/Color_Bash_Prompt#List_of_colors_for_prompt_and_Bash
Color_Off='\e[0m'       # Text Reset
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

dirname=`dirname $0`
mnt="$dirname/$MOUNT_PATH"

if [ type zenity >/dev/null 2>&1 ] ; then
	ENABLE_UI=0
fi

function mountShare {
	echo "Mounting samba filesystem..."
	if [ ! -d "$mnt" ] ; then
		mkdir "$mnt" 2>>/dev/null
	fi
	$SUDO_CMD mount -t cifs "//$HOST/$SHARE" "$mnt" -o $OPTIONS

	export BUP_DIR="$mnt"
}

function umountShare {
	echo "Unmounting samba filesystem..."
	$SUDO_CMD umount "$mnt"
}
