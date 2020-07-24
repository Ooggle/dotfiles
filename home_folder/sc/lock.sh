#!/bin/bash
scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
[[ -f ~/sc/media/key1.png ]] && convert /tmp/screen.png ~/sc/media/key1.png -gravity center -composite -matte /tmp/screen.png
i3lock -n -i /tmp/screen.png
rm /tmp/screen.png
