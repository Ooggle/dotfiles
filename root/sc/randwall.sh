#!/bin/bash

backnumber=$(ls -t /root/.config/i3/ | grep background | wc -l)

randnumber=$(expr $RANDOM % $backnumber + 1)

randfile=$(ls -t .config/i3/ | grep -m$randnumber background | tail -n1)

feh --bg-fill /root/.config/i3/$randfile
