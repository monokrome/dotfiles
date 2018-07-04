export ZSH_CONFIG_PATH=${HOME}/.config/zsh
export ZSH_PLUGIN_PATH=${ZSH_CONFIG_PATH}/external/**(N)


sourceall() {
    for filename in $@; do
        source "$filename"
    done
}


sourceall ${ZSH_CONFIG_PATH}/*.zsh(N)
sourceall ${ZSH_CONFIG_PATH}/plugins/*.zsh(N)


for plugin in ${ZSH_CONFIG_PATH}/external/*; do
  source_file=${plugin}/${plugin:t}.zsh
  [[ -f ${source_file} ]] || continue
  source ${source_file}

  after_config=${plugin:h}/after-${plugin:t}.zsh
  [[ -f ${after_config} ]] || continue
  source ${after_config}
done

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export N_PREFIX="$HOME/.local/share/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
