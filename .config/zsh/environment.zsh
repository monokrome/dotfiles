export EDITOR=vim
export GOPATH=~/.config/go
export HOMEBREW_GITHUB_API_TOKEN=$GITHUB_API_TOKEN
export ELECTRON_DEBUG=1
export GPG_TTY=$(tty)


# Share history between all shells, but don't save anywhere
HISTFILE=$HOME/.zsh_history
SAVEHIST=0
HISTSIZE=10000


path=($GOPATH/bin .bin ./node_modules/.bin $HOME/bin /usr/local/bin /Users/monokrome/.local/bin $path)
export WEBDEV_ECHO_COMMANDS=1
