# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="blinks"

COMPLETION_WAITING_DOTS="true"

plugins=(
  osx
  node
  heroku
  golang
  brew
  django
  npm
  pip
  python
  battery
  lol
  mercurial
  osx
  sprunge
  sublime
  svn
  systemd
  themes
  vagrant
  urltools
  wakeonlan
  knife
  vi-mode
  zle-vi-visual
  history-substring-search
  ruby
  gem
  zsh-syntax-highlighting
  user-highlighting
)

additional_paths=(
  "/Users/${USER}/bin"
  "/usr/local/sbin"
  "/usr/local/share/npm/bin"
  "/usr/local/bin"
  "./node_modules/.bin"
  "./bin"
  "/usr/bin"
  "/bin"
  "/usr/sbin"
  "/sbin"
  "/usr/local/bin"
  "/usr/local/Cellar/ruby/2.0.0-p195/bin"
)

source $ZSH/oh-my-zsh.sh

# Optional - disable autocorrect.
# unsetopt correct_all

# Customize to your needs...
for pathname in ${additional_paths[@]}; do
  if [[ -d "${pathname}" ]]; then
    export PATH="${pathname}:$PATH"
  else
    if [[ ! "${pathname:0:1}" == "." ]]; then
      echo "WARN: Deprecated path in additional_paths: ${pathname}"
    fi
  fi
done

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

cl() {
  cd $1 &&
  ls
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
nocorrectFile="${HOME}/.zsh_nocorrect"
if [ -f "${nocorrectFile}" ]; then
    while read -r command; do
        if [ $command ]; then
            alias $command="nocorrect $command"
        fi
    done < ${nocorrectFile}
fi

# Add nice suffixes
suffixFile="${HOME}/.zsh_suffix"
if [[ -f "${suffixFile}" ]]; then
    while read -r suffix; do
        if [[ ! -z "$suffix" ]]; then
            aliasArguments=$(echo "$suffix" | sed 's/ /=/')
            alias -s ${aliasArguments}
        fi
    done < ${suffixFile}
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

export MYVIMRC=${HOME}/.vim/vimrc

export CLITUNES_LIBRARY_FILE='/Volumes/Storage/Media/Applications/iTunes/iTunes\ Library.itl'

export MINECRAFT_MAX_MEMORY=2048

export PYTHONPATH=$(which python)
export DISABLE_UPDATE_PROMPT=true

# ZSH_HIGHLIGHT_STYLES[precommand]='fg=blue'
# ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'

export DISABLE_UPDATE_PROMPT=true
export ZSH_CUSTOM="${HOME}/.config/oh-my-zsh"

