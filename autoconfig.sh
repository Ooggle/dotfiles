#!/bin/bash

# intro
echo ""
echo "--------------------------------------------------"
echo "            - Auto configure script -"
echo "   This script need to run with root privileges."
echo "Please use this with a Ubuntu/Debian based distro."
echo "--------------------------------------------------"
echo ""

echo ""
echo "--------------------------------------------------"
echo "           - Installing dependencies -"
echo "--------------------------------------------------"
echo ""

# install base dependencies
apt -y install xorg i3 i3blocks

# install dependencies
apt -y install feh maim xclip pulseaudio rxvt-unicode \
xserver-xorg-input-synaptics scrot ffmpeg imagemagick xdotool libncurses5-dev \
git make xdg-utils pkg-config build-essential vim

# installing Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt -y install ./google-chrome-stable_current_amd64.deb

# move config files
cp -r etc/ /
cp -r root/ /
cp -r usr/ /

# install nerd fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DroidSansMono.zip
unzip DroidSansMono.zip -d ~/.fonts
fc-cache -fv
rm -r DroidSansMono.zip

# install noto font
apt install fonts-noto-color-emoji

# set chrome as default x web browser
xdg-settings set default-web-browser chrome.desktop

# install cfiles
git clone https://github.com/mananapr/cfiles.git
cd cfiles
make
make install
ln -s -f /usr/bin/cfiles /usr/bin/cf
cd .. && rm -r cfiles

#CURRENTDIR=$(pwd)
#cd ..
#rm -r $CURRENTDIR

echo "-------------------------------"
echo "    Configuration complete."
echo "You can now remove this folder."
echo "-------------------------------"
