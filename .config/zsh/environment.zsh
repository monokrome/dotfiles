export EDITOR=vim
export GOPATH=~/.config/go
export HOMEBREW_GITHUB_API_TOKEN=$GITHUB_API_TOKEN
export ELECTRON_DEBUG=1
export GPG_TTY=$(tty)


path=($GOPATH/bin .bin ./node_modules/.bin $HOME/bin /usr/local/bin ${HOME}/.local/bin ${HOME}/.cabal/bin $path)
export WEBDEV_ECHO_COMMANDS=1
