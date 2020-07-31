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
apt -y install feh maim scrot xclip pulseaudio rxvt-unicode \
xserver-xorg-input-synaptics ffmpeg imagemagick xdotool libncurses5-dev \
git make xdg-utils pkg-config build-essential vim pavucontrol lxappearance \
gtk2-engines-murrine gtk2-engines-pixbuf ncdu gparted python3 python3-pip xinput

pip3 install ueberzug

# installing Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt -y install ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# i3 rounded corners

echo ""
echo "--------------------------------------------------"
echo "            - Installing i3 Rounded -"
echo "--------------------------------------------------"
echo ""

apt -y install dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev \
xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev \
libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev \
libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev \
libxcb-shape0 libxcb-shape0-dev

git clone https://github.com/resloved/i3/ && cd i3
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make -j8
make install
cd ../..
rm -r i3

apt -y remove libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb1-dev \
libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev \
libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev \
libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm-dev libxcb-shape0-dev
apt -y autoremove

# Vimix theme

echo ""
echo "--------------------------------------------------"
echo "           - Installing Vimix Theme -"
echo "--------------------------------------------------"
echo ""

git clone https://github.com/vinceliuice/vimix-gtk-themes && cd vimix-gtk-themes
./install.sh -t ruby
cd ..
rm -r vimix-gtk-themes

git clone https://github.com/vinceliuice/vimix-icon-theme && cd vimix-icon-theme
./install.sh -a
cd ..
rm -r vimix-icon-theme

sed -i 's/gtk-theme-name=.*/gtk-theme-name=vimix-dark-ruby/g' ~/.config/gtk-3.0/settings.ini
sed -i 's/gtk-icon-theme=.*/gtk-icon-theme=Vimix-Ruby-dark/g' ~/.config/gtk-3.0/settings.ini

# move config files
cp -r etc/ /
cp -r home_folder/ ~/
cp -r usr/ /

# install shortcuts
install usr/bin/chrome /usr/bin/chrome
install usr/bin/discord /usr/bin/discord
install usr/bin/vscode /usr/bin/vscode
ln -s /usr/bin/python3 /usr/bin/py

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

echo ""
echo "--------------------------------------------------"
echo "             Configuration complete."
echo "         You can now remove this folder."
echo "--------------------------------------------------"
echo ""
