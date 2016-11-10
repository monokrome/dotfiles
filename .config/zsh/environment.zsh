path=($GOPATH/bin .bin/ ./node_modules/.bin $HOME/bin /usr/local/bin/ $path)


export EDITOR=nvim
export GOPATH=~/.config/go
export HOMEBREW_GITHUB_API_TOKEN=$GITHUB_API_TOKEN


# Share history between all shells, but don't save anywhere
HISTFILE=$HOME/.zsh_history
SAVEHIST=0
HISTSIZE=10000
