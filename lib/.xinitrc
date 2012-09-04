#!/bin/bash

# An additional script that will execute for wm-specific configuration
wm_script_dir=${HOME}/.config/wm/${1}

# Execute the window manager and save it's pid for later
exec $1 &
wm_pid=$!

# A bit of a time gap for the window manager to get started.
sleep 1

# Appearance related things
which xrdb

if [[ $? == 0 && -f ${HOME}/.Xresources ]]; then
  xrdb -merge ${HOME}/.Xresources
fi

if [[ -d ${HOME}/Pictures/Wallpapers ]]; then
  feh --bg-tile $(rf ${HOME}/Pictures/Wallpapers)
fi

which xbindkeys > /dev/null 2> /dev/null

if [[ $? == 0 ]]; then
  xbindkeys &
fi

if [[ -d "${wm_script_dir}" ]]; then
  run-parts ${wm_script_dir} &
fi

which update-outputs > /dev/null 2> /dev/null

if [[ $? == 0 ]]; then
  update-outputs &
fi

which dropbox > /dev/null 2> /dev/null
dropbox_result=$?

if [[ $dropbox_result == 0 ]]; then
  dropbox start &
fi

if [[ $1 == "dwm" ]]; then
  wmname LG3D
fi

# Wait for the WM to close before this script and it's subprocesses exit
wait ${wm_pid}

if [[ $dropbox_result == 0 ]]; then
  dropbox stop
fi

