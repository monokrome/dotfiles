#!/usr/bin/env bash

add_configuration Pictures/Wallpapers/Smokey_by_monokrome.png

installVim() {
  vim_path="${HOME}/.vim"

  if [[ ! -d "${vim_path}" ]]; then
    cd "$HOME" &&
    git clone http://github.com/monokrome/vim-config .vim > /dev/null 2> /dev/null &&

    cd "${vim_path}" &&
    gits populate > /dev/null 2> /dev/null 
  fi

  vim '+silent BundleInstall' '+qa!' > /dev/null 2> /dev/null &&

  cd "${vim_path}/bundle/YouCompleteMe/" > /dev/null 2> /dev/null &&
  ./install.sh --clang-completer > /dev/null 2> /dev/null &&

  info 'Done installing & configuring Vim.'
}

info 'Installing & configuring Vim (in background)'
installVim &
