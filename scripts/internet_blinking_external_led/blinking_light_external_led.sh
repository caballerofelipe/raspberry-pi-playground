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

# About how I selected the pin, see this:
# https://raspberrypi.stackexchange.com/q/149521/115939
GPIO_USED=525

if test ! -d /sys/class/gpio/gpio$GPIO_USED; then
	echo "GPIO pin hasn't been exported"
	exit 1
else
	if test ! "$(cat /sys/class/gpio/gpio$GPIO_USED/direction)" = "out"; then
		echo "Direction wrong"
		exit 1
	fi

	while : ; do
		echo 1 > /sys/class/gpio/gpio$GPIO_USED/value
		sleep 0.1
		echo 0 > /sys/class/gpio/gpio$GPIO_USED/value
		sleep 0.1
		echo 1 > /sys/class/gpio/gpio$GPIO_USED/value
		sleep 0.1
		echo 0 > /sys/class/gpio/gpio$GPIO_USED/value
		sleep 2
	done
fi


# The same as above can be done with pinctrl, however, from my understanding this access the
# pins directly and could potentially be harmful because of this
#
# This is what is stated at the beginning when doing `pinctrl help`:
# > WARNING! pinctrl set writes directly to the GPIO control registers
# > ignoring whatever else may be using them (such as Linux drivers) -
# > it is designed as a debug tool, only use it if you know what you
# > are doing and at your own risk!
# pinctrl 13 op
# while : ; do
# 	pinctrl 13 dh
# 	sleep 0.1
# 	pinctrl 13 dl
# 	sleep 0.1
# 	pinctrl 13 dh
# 	sleep 0.1
# 	pinctrl 13 dl
# 	sleep 2
# done
