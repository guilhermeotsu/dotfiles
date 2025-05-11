#!/bin/bash

DEVICE="sdb"

echo "Waiting for $DEVICE"

while true; do
    if lsblk | grep -q "^$DEVICE"; then
        echo "$DEVICE detected"
        # mount device
        # cp uf2 to my device 
        # umount device
        break
    fi
    sleep 1
done

echo "Done"
