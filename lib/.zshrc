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
plugins=(osx node heroku golang brew django npm pip python battery lol mercurial osx sprunge sublime svn systemd themes vagrant urltools wakeonlan knife vi-mode zle-vi-visual history-substring-search rvm ruby gem)

source $ZSH/oh-my-zsh.sh

# Optional - disable autocorrect.
# unsetopt correct_all

# Customize to your needs...
export PATH=/Users/${USER}/bin:$HOME/.rvm/bin:/usr/local/sbin:/usr/local/share/npm/bin:/usr/local/bin:/usr/local/share/python:./node_modules/.bin:./bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/Cellar/ruby/2.0.0-p195/bin:$PATH

export EDITOR=vim

PROMPT='%{%K{black}%B%F{green}%}%n%{%B%F{blue}%}@%{%B%F{cyan}%}%m%{%B%F{green}%} %{%b%F{yellow}%K{black}%}%~%{%B%F{green}%}$(git_prompt_info)%E%{%f%k%b%}%{%K{black}%}$(_prompt_char)%{%K{black}%} %#%{%f%k%b%} '

alias p=yaourt
alias it=clitunes

export DEBUG=True
unsetopt share_history

function ls() {
  clear
  command ls $@
  echo
}

dirof_open_command="open"

function dirof() {
  if [[ -z "${1}" ]]; then
    echo 'Usage: dirof <executable>'
    return
  fi

  if [[ -z "${2}" ]]; then
    exec_command="${dirof_open_command}"
  else
    exec_command="${2}"
  fi

  filename="$(which ${1})"

  if [[ ! -z "${filename}" ]]; then
    file_dirname=$(dirname "${filename}")
    ${exec_command} "${file_dirname}"
  fi
}

if [ -f ~/.zsh_secrets ]; then
  source ~/.zsh_secrets
fi

# Fix annoying corrections
if [ -f ~/.zsh_nocorrect ]; then
    while read -r COMMAND; do
        if [ $COMMAND ]; then
            alias $COMMAND="nocorrect $COMMAND"
        fi
    done < ~/.zsh_nocorrect
fi

RPS1='$(vi_mode_prompt_info)'
RPS2=$RPS1

zle -N zle-line-init
zle -N zle-keymap-select

export GOBIN=/usr/local/bin
export GOROOT=/usr/local/Cellar/go/1.0.3/

export PIP_DOWNLOAD_CACHE=${HOME}/.pip/cache

export WORKON_HOME=${HOME}/.config/virtualenv
export PROJECT_HOME=${HOME}/Projects
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/share/python/virtualenvwrapper.sh
source /usr/local/share/python/virtualenvwrapper_lazy.sh

export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--distribute'

alias g="git $@ | tig"
alias mkb='vim `mk blog`'

alias top=htop

chef_bin_dir=/opt/chef/embedded/bin

if [[ -f "${chef_bin_dir}" ]]; then
  echo 'export PATH="${chef_bin_dir}:$PATH"' >> ~/.bash_profile && source ~/.bash_profile
fi

