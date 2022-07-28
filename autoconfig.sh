#!/bin/bash

# change this variable to use your own terminal (default is urxvt (rxvt-unicode))
term=lxterminal
user=ooggle
browser=brave-browser

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

# install lxterminal
apt update
apt -y upgrade
apt -y install $term

# install base dependencies
apt -y install xorg i3 i3blocks

# install dependencies
apt -y install feh maim scrot xclip curl wget light pulseaudio rxvt-unicode ffmpeg \
imagemagick xdotool libncurses5-dev git make xdg-utils pkg-config \
build-essential vim pavucontrol lxappearance ncdu python3 python3-pip \
python-is-python3 python2 xinput gsettings-desktop-schemas nemo rsync \
rofi notepadqq libnotify-bin playerctl mpv

# config light suid

chmod +s /usr/bin/light

# i3 rounded corners

echo ""
echo "--------------------------------------------------"
echo "              - Installing i3 Gaps -"
echo "--------------------------------------------------"
echo ""

apt -y install i3 meson libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
libstartup-notification0-dev libxcb-randr0-dev \
libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev

git clone https://www.github.com/Airblader/i3 && cd i3
mkdir -p build && cd build
meson ..
ninja
cd ../..
rm -rf i3

apt -y remove meson libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb1-dev \
libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev \
libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev \
libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm-dev libxcb-shape0-dev

echo ""
echo "--------------------------------------------------"
echo "           - Installing Vimix Theme -"
echo "--------------------------------------------------"
echo ""

# depedencies
sudo apt -y install sassc

git clone https://github.com/vinceliuice/vimix-gtk-themes && cd vimix-gtk-themes
./install.sh -t ruby
cd ..
rm -rf vimix-gtk-themes

git clone https://github.com/vinceliuice/vimix-icon-theme && cd vimix-icon-theme
./install.sh -a
cd ..
rm -rf vimix-icon-theme

sed -i 's/gtk-theme-name=.*/gtk-theme-name=vimix-dark-ruby/g' /home/$user/.config/gtk-3.0/settings.ini
sed -i 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=Vimix-Ruby-dark/g' /home/$user/.config/gtk-3.0/settings.ini

echo ""
echo "--------------------------------------------------"
echo "          - Installing Brave Browser -"
echo "--------------------------------------------------"
echo ""

apt -y install apt-transport-https curl
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave-browser-release.list
apt update && apt -y install brave-browser

echo ""
echo "--------------------------------------------------"
echo "                - Other configs -"
echo "--------------------------------------------------"
echo ""

# install nerd fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DroidSansMono.zip
unzip -o DroidSansMono.zip -d /usr/local/share/fonts/
fc-cache -fv
rm -f DroidSansMono.zip

# install noto font
apt install fonts-noto-color-emoji

# move config files
chmod -R 755 etc/
chown -R root: etc/
cp -ar etc/. /etc/

chmod -R 755 home_folder/
chown -R $user: home_folder/
cp -ar home_folder/. /home/$user/

chmod -R 755 usr/
chown -R $user: usr/
cp -ar usr/. /usr/

# change PS1
echo "PS1='\t ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '" >> ~/.bashrc

# set Brave as default x web browser
xdg-mime default $browser.desktop x-scheme-handler/http

# set nemo "open in terminal context menu"
ln -fs $(which $term) /etc/alternatives/x-terminal-emulator

#CURRENTDIR=$(pwd)
#cd ..
#rm -r $CURRENTDIR

apt -y autoremove

echo ""
echo "--------------------------------------------------"
echo "             Configuration complete."
echo "         You can now remove this folder."
echo "--------------------------------------------------"
echo ""
