#!/usr/bin/env zsh

export EDITOR=vim
export GOPATH=~/.config/go
export HOMEBREW_GITHUB_API_TOKEN=$GITHUB_API_TOKEN
export ELECTRON_DEBUG=1
export GPG_TTY=$(tty)


path=($GOPATH/.local/bin /usr/local/bin ${HOME}/.local/bin ${HOME}/.cabal/bin $path)
