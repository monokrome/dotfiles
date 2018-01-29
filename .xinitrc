#!/usr/bin/env zsh

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

path=(${HOME}/bin $path)

wm=$1
[[ -z $wm ]] && wm=dwm

wm_path=${HOME}/.config/wm/${wm}

[[ ! -d $wm_path ]] && exec $wm

for wm_script in ${wm_path}/*; do
  source ${wm_script}
done

running_jobs=`jobs -p`
[[ ! -z ${running_jobs} ]] && kill ${running_jobs}
