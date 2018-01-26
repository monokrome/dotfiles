#!/usr/bin/env sh

sleep 3

xbindkeys &
onboard -a &
start-pulseaudio-x11 &
rotate_backgrounds &
compose &
touchegg &
cbatticon -n &
volumeicon &
dwmstatus &
statnot &

dwm
