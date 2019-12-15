#!/bin/bash

if [ -z "$1" ]
then
        echo "PLEASE CHOOSE AN OPTION : dleft / dright / none "
        echo "exiting..."
        exit
fi

if [ $1 = "dleft" ]
then
        echo "setting second screen to left screen"
	xrandr --auto
        xrandr --output eDP-1 --auto --right-of HDMI-1
        #reload wallpaper
	feh --bg-fill /root/.config/i3/background.png
        exit
fi

if [ $1 = "dright" ]
then
        echo "setting second screen to right screen"
	xrandr --auto
        xrandr --output eDP-1 --auto --left-of HDMI-1 
        #reload wallpaper
        feh --bg-fill /root/.config/i3/background.png
        exit
fi

if [ $1 = "none" ]
then
        echo "removing second screen"
	xrandr --output HDMI-1 --off
        #reload wallpaper
        feh --bg-fill /root/.config/i3/background.png
        exit
fi
