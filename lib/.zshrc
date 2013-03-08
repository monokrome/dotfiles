# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="blinks"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git gitfast git-remote-branch osx node heroku github brew django gem npm pip python vi-mode battery bwana history-substring-search lol mercurial osx sprunge sublime ssh-agent svn)

source $ZSH/oh-my-zsh.sh

# Optional - disable autocorrect.
# unsetopt correct_all

# Customize to your needs...
export PATH=//Users/bstoner/bin:/usr/local/share/npm/bin:/usr/local/bin:/usr/local/share/python:./node_modules/.bin:./bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin

PROMPT='%{%K{black}%B%F{green}%}%n%{%B%F{blue}%}@%{%B%F{cyan}%}%m%{%B%F{green}%} %{%b%F{yellow}%K{black}%}%~%{%B%F{green}%}$(git_prompt_info)%E%{%f%k%b%}%{%K{black}%}$(_prompt_char)%{%K{black}%} %#%{%f%k%b%} '

alias p=yaourt

function ls() {
  clear
  command ls $@
  echo
}

# Fix annoying corrections
if [ -f ~/.zsh_nocorrect ]; then
    while read -r COMMAND; do
        if [ $COMMAND ]; then
            alias $COMMAND="nocorrect $COMMAND"
        fi
    done < ~/.zsh_nocorrect
fi

