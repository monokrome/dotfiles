#!/bin/bash

if [[ ! -e ~/.oh-my-zsh ]]; then
  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

add_configuration .screenrc
add_configuration .gitconfig
add_configuration .tmux.conf
add_configuration .vim
add_configuration .vimrc
add_configuration .hushlogin

if [[ $SHELL != $(which zsh) ]]; then
  echo '======> Changing shell to zsh...'
  chsh -s `which zsh`
else
  echo '======> Current shell is already zsh. Not changing.'
fi


