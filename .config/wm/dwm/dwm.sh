#!/usr/bin/env sh

sleep 3

xbindkeys &
onboard -a -t Nightshade -l Small &
start-pulseaudio-x11 &
rotate_backgrounds &
compose &
touchegg &
cbatticon -n &
volumeicon &
dwmstatus &
statnot &

dwm
