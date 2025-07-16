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
    xrandr --output LVDS-1 --primary --mode 1366x768 --scale 1x1 --pos 0x0 --rotate normal \
          --output VGA-1 --off \
          --output HDMI-1 --off \
          --output DP-1 --off \
          --output HDMI-2 --off \
          --output HDMI-3 --off \
          --output DP-2 --off \
          --output DP-3 --off
fi
