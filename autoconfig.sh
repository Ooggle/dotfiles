#!/bin/bash

# intro
echo "- Auto configure script -"
echo "This script need to run with root privileges."
echo "Please use this with a Ubuntu/Debian based distro."

# install dependencies
apt -y install i3blocks feh maim xclip pulseaudio rxvt-unicode \
xserver-xorg-input-synaptics scrot ffmpeg imagemagick xdotool

# move config files
mv etc/ /
mv root/ /
mv usr/ /

# install nerd fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DroidSansMono.zip
unzip DroidSansMono.zip -d ~/.fonts
fc-cache -fv
rm -r DroidSansMono.zip

# set chrome as default x web browser
xdg-settings set default-web-browser chrome.desktop

#remove folder after finished
CURRENTDIR=$(pwd)
cd ..
rm -r $CURRENTDIR
echo "Configuration complete."
