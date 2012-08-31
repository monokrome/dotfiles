#!/bin/sh

if [[ ! -e ~/.oh-my-zsh ]]; then
  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

add_configuration .screenrc
add_configuration .gitconfig
add_configuration .tmux.conf
add_configuration .vim
add_configuration .vimrc
add_configuration .Xdefault

