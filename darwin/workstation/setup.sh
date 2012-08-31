#!/bin/sh

if [[ ! -e ~/.oh-my-zsh ]]; then
  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

add_configuration .screenrc
add_configuration .gitconfig
add_configuration .tmux.conf
add_configuration .vim
add_configuration .vimrc
add_configuration .Xdefaults
add_configuration .hushlogin
add_configuration .iterm2

if [[ $SHELL != $(which zsh) ]]; then
  echo '======> Changing shell to zsh...'
  chsh -s `which zsh`
else
  echo '======> Current shell is already zsh. Not changing.'
fi

if [[ $operating_system == darwin ]]; then
  echo '======> Updating iTerm2 configuration...'
  defaults write com.googlecode.iterm2 PrefsCustomFolder ~/.iterm2
fi

