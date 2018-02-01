#!/usr/bin/env sh

sleep 3

xbindkeys &
onboard -a &
start-pulseaudio-x11 &
user-wallpapers &
user-screen-rotation &
user-compositor &
touchegg &
cbatticon -n &
volumeicon &
user-statusline &
user-notifications &
user-touchpad &

dwm
