#!/bin/bash

# ********************** #
# Blinks the PWR (power) led on the Raspberry Pi
# Tested on Raspberry Pi 4
#
# Raspberry Pi on board lights
# 	https://www.techiebouncer.com/2020/02/control-power-and-act-led-of-raspberry.html
#
# FCG Felipe Caballero Gil
# ********************** #

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "Run this script as root (or using sudo)."
   exit 1
fi

while : ; do
	echo 1 > /sys/class/gpio/gpio17/value
	sleep 0.1
	echo 0 > /sys/class/gpio/gpio17/value
	sleep 0.1
	echo 1 > /sys/class/gpio/gpio17/value
	sleep 0.1
	echo 0 > /sys/class/gpio/gpio17/value
	sleep 2
done
