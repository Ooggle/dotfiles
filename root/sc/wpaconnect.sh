#!/bin/bash

if [ -z "$1" ]
then
    echo "PLEASE CHOOSE A WPA CONFIG FILE "
    echo "exiting..."
    exit
else
    killall wpa_supplicant & killall dhclient
    wpa_supplicant -D nl80211 -B -i wlp2s0 -c $1
    dhclient wlp2s0
    exit
fi
