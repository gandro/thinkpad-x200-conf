#!/bin/bash
export DISPLAY=:0.0
export XAUTHORITY=/var/run/slim.auth
exec xrandr --output VGA1 --auto --right-of LVDS1
