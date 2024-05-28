#!/bin/sh
#
swayidle -w timeout 180 'swaylock -f -c 000000' \
	timeout 210 'hyprctl dispatch dpms off' \
	resume 'hyprctl dispatch dpms on' \
	timeout 600 'systemctl suspend' \
	before-sleep 'swaylock -f -c 000000'
