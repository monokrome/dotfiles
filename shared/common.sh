#!/usr/bin/env bash

add_configuration Pictures/Wallpapers/Smokey_by_monokrome.png

vim_path="${HOME}/.vim"

if [[ ! -d "${vim_path}" ]]; then
  info 'Cloning Vim configuration repository'

  cd "$HOME" &&
  git clone http://github.com/monokrome/vim-config .vim > /dev/null 2> /dev/null &&

  cd "${vim_path}" &&
  gits populate > /dev/null 2> /dev/null 
fi

info 'Installing new Vim bundles'
vim '+silent BundleInstall' '+qa!' > /dev/null 2> /dev/null 

info 'Rebuilding YouCompleteMe'
cd "${vim_path}/bundle/YouCompleteMe/" && ./install.sh --clang-completer > /dev/null 2> /dev/null 
