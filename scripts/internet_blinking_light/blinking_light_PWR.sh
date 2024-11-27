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
	# echo 1 > /sys/class/leds/led1/brightness # Worked on Raspbian not on Raspberry Pi OS
	echo 1 > /sys/class/leds/PWR/brightness
	sleep 0.1
	# echo 0 > /sys/class/leds/led1/brightness # Worked on Raspbian not on Raspberry Pi OS
	echo 0 > /sys/class/leds/PWR/brightness
	sleep 0.1
	# echo 1 > /sys/class/leds/led1/brightness # Worked on Raspbian not on Raspberry Pi OS
	echo 1 > /sys/class/leds/PWR/brightness
	sleep 0.1
	# echo 0 > /sys/class/leds/led1/brightness # Worked on Raspbian not on Raspberry Pi OS
	echo 0 > /sys/class/leds/PWR/brightness
	sleep 2
done
