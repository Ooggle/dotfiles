#!/bin/bash

SCREEN1=$(xrandr|grep eDP |awk '{print $1}')
SCREEN2=$(xrandr|grep HDMI |awk '{print $1}')
STATUS=$(xrandr |grep HDMI |awk '{print $2}')

if [ -z "$1" ]
then
    POSITION="right"
else
    POSITION=$1
fi

if [ $POSITION = "none" ]
then
    echo "removing second screen"
    xrandr --output $SCREEN2 --off
    #reload wallpaper
    source ~/sc/randwall.sh
    exit
fi

if [[ $STATUS -eq "connected" ]];
then
    xrandr --auto
    xrandr --output $SCREEN2 --auto --$POSITION-of $SCREEN1
    echo "setting second screen"
    #reload wallpaper
    source ~/sc/randwall.sh
    exit
else
    xrandr --auto
    echo "refreshing screen"
    #reload wallpaper
    source ~/sc/randwall.sh
    exit
fi

