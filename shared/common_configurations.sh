#!/bin/bash

if [[ ! -e ~/.oh-my-zsh ]]; then
  which curl > /dev/null

  if [[ $? == 0 ]]; then
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
  else
    wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
  fi
fi

add_configuration .screenrc
add_configuration .gitconfig
add_configuration .tmux.conf
add_configuration .vim
add_configuration .vimrc
add_configuration .bash_profile
add_configuration .bashrc
add_configuration .zshrc
add_configuration .zsh_nocorrect
add_configuration .zsh_suffix
add_configuration .pentadactylrc
add_configuration .pentadactyl
add_configuration .config/cli-shims
add_configuration bin/rf
add_configuration .weechat/python/go.py
add_configuration .weechat/python/autoload/go.py
add_configuration .htoprc
add_configuration .config/git
add_configuration .ctags

if [[ $SHELL != $(which zsh) ]]; then
  info 'Changing shell to zsh...'
  chsh -s `which zsh`
else
  info 'Current shell is already zsh. Not changing.'
fi

vim_directory="${repository_root}/lib/.vim"
vim_bundle_directory="${vim_directory}/bundle"
