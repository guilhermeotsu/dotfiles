#!/bin/sh
xrandr --output DP-1 --mode 1920x1080 --primary \
             --output LVDS-1 --mode 1366x768 --scale-from 1920x1080 --same-as DP-1
