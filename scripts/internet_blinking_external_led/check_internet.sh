#!/bin/bash

# ********************** #
# This file checks if internet is working using ping
# 	If it's working it turns the power (PWR) light on the Raspberry Pi.
# 	If it's not working it fires the script called blinking_light_PWR.sh in this directory
#
# The light is an indicator so use it knowingly
#	See https://www.raspberrypi.org/documentation/configuration/led_blink_warnings.md
#
# Raspberry Pi on board lights
# 	https://www.techiebouncer.com/2020/02/control-power-and-act-led-of-raspberry.html
#
# Similar project but with external light
#	https://www.instructables.com/id/Raspberry-Pi-Internet-Monitor/
#
# FCG Felipe Caballero Gil
# ********************** #

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "Run this script as root (or using sudo)."
   exit 1
fi

# Obtained from http://www.ostricher.com/2014/10/the-right-way-to-get-the-directory-of-a-bash-script/
get_script_dir () {
	SOURCE="${BASH_SOURCE[0]}"
	# While $SOURCE is a symlink, resolve it
	while [ -h "$SOURCE" ]; do
		DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
		SOURCE="$( readlink "$SOURCE" )"
		# If $SOURCE was a relative symlink (so no "/" as prefix, need to resolve it relative to the symlink base directory
		[[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
	done
	DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
	echo "$DIR"
}

# Configure and turn off
echo 17 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio17/direction
echo 1 > /sys/class/gpio/gpio17/value

script_dir=$(get_script_dir)
blinking_light_PWR_pid=$(cat $script_dir/blinking_light_PWR.pid)

# Check if internet is working
#	'-c 1' = send only 1 package
#	'-W 5' = timeout after 5 seconds, on Linux. For mac this option is different.
# Use IP instead of domain as the DNS tries to solve the address before the ping is sent
ping -c 1 -W 5 172.217.192.101 # Google

if [ $? -eq 0 ]; then
	# Internet OK
	echo "Internet OK"
	# For 'kill -0 pid' see https://stackoverflow.com/a/3044045/1071459
	# "-n" = not empty
	if [ -n "$blinking_light_PWR_pid" ] && kill -0 $blinking_light_PWR_pid > /dev/null 2>&1
	then
		echo Killing blinking_light_PWR.sh \(PID: $blinking_light_PWR_pid\)
		kill $blinking_light_PWR_pid
	fi
	printf "" > $script_dir/blinking_light_PWR.pid
	echo 1 > /sys/class/gpio/gpio17/value # Turn off
else
	# Internet NOT OK
	echo "Internet NOT OK"
	# ""-z" empty
	if [ -z "$blinking_light_PWR_pid" ]; then
		echo Setting blinking_light_PWR_pid
		bash $script_dir/blinking_light_PWR.sh &
		printf $! >> $script_dir/blinking_light_PWR.pid
	fi
fi
