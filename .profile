#!/usr/bin/env sh

export PATH
export XDG_CONFIG_DIRS

XDG_CONFIG_DIRS=/usr/share/gnome

for new_path in ${HOME}/.*/bin; do
  PATH="${HOME}/${new_path}:${PATH}"
done

which ssh-agent && eval `ssh-agent -t 21600`
