#!/bin/bash

if [[ ! -e ~/.oh-my-zsh ]]; then
  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

add_configuration .screenrc
add_configuration .gitconfig
add_configuration .tmux.conf
add_configuration .vim
add_configuration .vimrc
add_configuration .bash_profile
add_configuration .bashrc
add_configuration .zshrc
add_configuration .pentadactylrc
add_configuration .config/cli-shims
add_configuration bin/rf

if [[ $SHELL != $(which zsh) ]]; then
  info 'Changing shell to zsh...'
  chsh -s `which zsh`
else
  info 'Current shell is already zsh. Not changing.'
fi

vim_directory="${repository_root}/lib/.vim"
vim_bundle_directory="${vim_directory}/bundle"

# Checkout develop in the powerline repository due to a non-existant master.
cd "${vim_bundle_directory}/vim-powerline/"
git checkout develop > /dev/null 2> /dev/null
cd "${repository_root}"

