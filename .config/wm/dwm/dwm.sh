#!/usr/bin/env sh

user-wallpapers &
user-screen-rotation &
user-compositor &
user-touchpad &
user-notifications &
user-statusline &
xrdb .Xresources &
start-pulseaudio-x11 &
xbindkeys &
touchegg &
onboard -a &
cbatticon -n &
blueman-applet &
volumeicon &

dwm
