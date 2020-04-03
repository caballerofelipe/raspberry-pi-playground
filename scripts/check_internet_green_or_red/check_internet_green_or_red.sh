#!/bin/bash

pin_green=23
pin_red=24

# Turn off led, green
raspi-gpio set $pin_green op
raspi-gpio set $pin_green dl

# Turn off led, red
raspi-gpio set $pin_red op
raspi-gpio set $pin_red dl

# Check if internet is working
#	'-c 1' = send only 1 package
#	'-W 5' = timeout after 5 seconds, on Linux. For mac this option is different.
# Use IP instead of domain as the DNS tries to solve the address before the ping is sent
ping -c 1 -W 5 172.217.192.101 # Google

if [ $? -eq 0 ]; then
	# Turn on led, green
	raspi-gpio set $pin_green op
	raspi-gpio set $pin_green dh
else
	# Turn on led, red
	raspi-gpio set $pin_red op
	raspi-gpio set $pin_red dh
fi
