# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="blinks"

COMPLETION_WAITING_DOTS="true"

plugins=(
  battery
  brew
  django
  gem
  golang
  heroku
  jump
  lol
  mercurial
  node
  npm
  osx
  pip
  python
  ruby
  sprunge
  sublime
  svn
  systemd
  themes
  urltools
  user-highlighting
  vagrant
  wakeonlan
  zsh-syntax-highlighting

  zle-vi-visual
  history-substring-search
)

which gem > /dev/null
if [[ $? == 0 ]]; then
  gempath=$(gem env gempath)
  export PATH="${gempath}:${PATH}"
fi

source $ZSH/oh-my-zsh.sh

# Optional - disable autocorrect.
# unsetopt correct_all

additional_paths=(
  "${HOME}/bin"
  "${HOME}/.config/homebrew/bin"

  "./bin"
  "./node_modules/.bin"

  "/Applications/Postgres93.app/Contents/MacOS/bin"

  "/usr/local/bin"
  "/usr/local/sbin"

  "/usr/local/share/npm/bin"

  "/usr/bin"
  "/usr/sbin"

  "/bin"
  "/sbin"
)

source $ZSH/oh-my-zsh.sh

# Optional - disable autocorrect.
# unsetopt correct_all

# Customize to your needs...
for (( index=${#additional_paths[@]} - 1; index >= 0; index-- )); do
  pathname=${additional_paths[index]}

  if [[ "${pathname:0:2}" == './' || -d "${pathname}" ]]; then
    export PATH="${pathname}:$PATH"
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

# RPS1='$(vi_mode_prompt_info)'
# RPS2=$RPS1

# zle -N zle-line-init
# zle -N zle-keymap-select

if [[ -z $VMWARE_PATH ]]; then
  VMWARE_PATH="/Applications/VMware Fusion.app"
fi

if [[ -d "${VMWARE_PATH}" ]]; then
  vmheadless() {
    if [[ -z $1 ]]; then
      echo 'Usage: vmheadless YourMachine.vmx'
      return 1
    fi

    echo 'Running VM: ' $1
    /Applications/VMware\ Fusion.app/Contents/Library/vmrun -T fusion start "$1" nogui
  }
fi

export GOBIN=/usr/local/bin
export GOROOT=/usr/local/Cellar/go/1.0.3/

export PIP_DOWNLOAD_CACHE=${HOME}/.pip/cache

export PROJECT_HOME=${HOME}/Projects
export WORKON_HOME=${HOME}/.config/virtualenv

export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
export VIRTUALENVWRAPPER_SCRIPT_LAZY=/usr/local/bin/virtualenvwrapper_lazy.sh
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--distribute'

[[ -f "${VIRTUALENVWRAPPER_SCRIPT_LAZY}" ]] && source "${VIRTUALENVWRAPPER_SCRIPT_LAZY}"

alias g="git $@ | tig"
alias mkb='vim `mk blog`'

alias top=htop

chef_bin_dir=/opt/chef/embedded/bin

# if [[ -f "${chef_bin_dir}" ]]; then
#   echo 'export PATH="${chef_bin_dir}:$PATH"' >> ~/.bash_profile && source ~/.bash_profile
# fi

export MYVIMRC=${HOME}/.vim/vimrc
export CLITUNES_LIBRARY_FILE='/Volumes/Storage/iTunes/iTunes\ Library.itl'
export MINECRAFT_MAX_MEMORY=2048
export PYTHONPATH=$(which python)

# ZSH_HIGHLIGHT_STYLES[precommand]='fg=blue'
# ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'

export DISABLE_UPDATE_PROMPT=true
export ZSH_CUSTOM="${HOME}/.config/oh-my-zsh"
export AWS_CONFIG_FILE=${HOME}/.config/aws.ini
export SQLIST_CONFIGURATION=sqlist.json
export DOCKER_HOST=localhost
export JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.8.0_05.jdk/Contents/Home/'
