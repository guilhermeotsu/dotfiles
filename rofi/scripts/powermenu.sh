#!/usr/bin/env bash

chosen=$(printf "Power Off\nRestart\nLock" | rofi -dmenu -i -p "Power Options")

case "$chosen" in 
  "Power Off") poweroff ;;
  "Restart") reboot ;;
  "Lock") slock ;;
  *) exit 1 ;;
esac
