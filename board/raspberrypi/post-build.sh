#!/bin/sh

set -u
set -e

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

#puesto por mi para configurar wifi en rpi3
cp package/busybox/S10mdev ${TARGET_DIR}/etc/init.d/S10mdev
chmod 755 ${TARGET_DIR}/etc/init.d/S10mdev
cp package/busybox/mdev.conf ${TARGET_DIR}/etc/mdev.conf
cp board/raspberrypi3/interfaces ${TARGET_DIR}/etc/network/interfaces
cp board/raspberrypi3/wpa_supplicant.conf ${TARGET_DIR}/etc/wpa_supplicant.conf
#en el archivo profile definimos variables de entorno para EPICS y NTP
cp board/raspberrypi3/profile ${TARGET_DIR}/etc/profile
#el archivo ntp.conf configura el NTP de fecha y hora
cp board/raspberrypi3/ntp.conf ${TARGET_DIR}/etc/ntp.conf
