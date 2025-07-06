#!/bin/bash

export DISPLAY=:0
export XAUTHORITY=/home/$USER/.Xauthority
export PATH=/usr/bin:/bin

if xrandr | grep "DP-1 connected"; then
    # mirror laptop and external monitor
    xrandr --output DP-1 --mode 1920x1080 --primary \
           --output LVDS-1 --mode 1366x768 --scale-from 1920x1080 --same-as DP-1
else
  # laptop only
  xrandr \
        --output LVDS-1 --auto --primary \
        --output DP-1 --off
fi

