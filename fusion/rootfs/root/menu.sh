#!/bin/bash

logo() {
	echo " _______  __   __  _______  ___   _______  __    _ "
	echo "|       ||  | |  ||       ||   | |       ||  |  | |"
	echo "|    ___||  | |  ||  _____||   | |   _   ||   |_| |"
	echo "|   |___ |  |_|  || |_____ |   | |  | |  ||       |"
	echo "|    ___||       ||_____  ||   | |  |_|  ||  _    |"
	echo "|   |    |       | _____| ||   | |       || | |   |"
	echo "|___|    |_______||_______||___| |_______||_|  |__|"
	echo ""
	echo ""
	echo "THIS IS FREE SOFTWARE BY ICEDRAGON.IO"
	echo "IF YOU HAVE PAID FOR THIS SOFTWARE, YOU HAVE BEEN SCAMMED."
	echo ""
}

finished_flashing() {
	sync
	echo "System powering off..."
	sleep 2
	poweroff
}

#location of firmwares
FIRMWARE_LOC='/boot/fusion/firmware'

#location of the stock firmware for the flasher to find.
BACKUP_LOCATION='/boot/fusion/stock_piuio.ihex'
export BACKUP_LOCATION=$BACKUP_LOCATION

clear
logo

if [ ! -f $BACKUP_LOCATION ]; then
	echo "PIUIO Backup not found! One will be taken before flashing."
	echo ""
fi

PS3=$'\nPlease enter your choice: '
options=("LXIO" "Gamepad" "PIUIO" "Stock PIUIO" "Shell")
IFS=$'\n'
select opt in "${options[@]}"; do
	case $opt in
	"LXIO")
		flash $FIRMWARE_LOC/lxio.ihex
		finished_flashing
		break
		;;
	"Gamepad")
		flash $FIRMWARE_LOC/gamepad.ihex
		finished_flashing
		break
		;;
	"PIUIO")
		flash $FIRMWARE_LOC/piuio.ihex
		finished_flashing
		break
		;;
	"Stock PIUIO")
		flash $BACKUP_LOCATION
		finished_flashing
		break
		;;
	"Shell")
		clear
		break
		;;
	*) echo "invalid option $REPLY" ;;
	esac
done

#try and flush to disk.
sync
