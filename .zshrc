#!/usr/bin/env zsh


[[ ! -z $ZSH_DEBUG ]] && set -x


export ZSH_CONFIG_PATH=${HOME}/.config/zsh
export ZSH_PLUGIN_PATH=${ZSH_CONFIG_PATH}/external/**(N)


func __zsh_info() {
  echo $@
}


sourceall() {
    for filename in $@; do
        source "$filename"
    done
}


setopt extended_glob
local_config_paths=(${ZSH_CONFIG_PATH}/local/*.zsh(.N))
plugin_paths=(${ZSH_CONFIG_PATH}/{plugins,external}/(^after-)*.zsh(.N))
plugin_after_paths=(${ZSH_CONFIG_PATH}/{external,plugins}/after-*.zsh(.N))
unsetopt extended_glob


for plugin in ${local_config_paths[@]}; do
  plugin_name=${plugin:t}
  printf 'Configuring %s' "${plugin_name}"
  source "${plugin}" && echo ' [DONE]' || echo '[FAIL]'
done


for plugin in ${plugin_paths[@]}; do
  plugin_name=${plugin:t}
  printf 'Initializing %s' "${plugin}"
  source "${plugin}" && echo ' [DONE]' || echo '[FAIL]'
done


for plugin in ${plugin_after_paths[@]}; do
  after_config=${plugin:h}/after-${plugin:t}.zsh
  [[ -f ${after_config} ]] || continue

  printf 'Culminating %s' "${plugin}"
  source "${after_config}" && echo ' [DONE]' || echo '[FAIL]'
done


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ -z $ZSH_DEBUG ]]; then
  clear
else
  set +x
fi
