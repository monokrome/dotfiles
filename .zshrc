#!/usr/bin/env zsh


[ ! -z $zsh_debug ] && set -x


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
  [ ! -z $ZSH_DEBUG ] && printf 'Configuring %s' "${plugin_name}"
  source "${plugin}" && [ ! -z $ZSH_DEBUG ] && echo ' [DONE]' || [ ! -z $ZSH_DEBUG ] && echo '[FAIL]'
done


for plugin in ${plugin_paths[@]}; do
  plugin_name=${plugin:t}
  [ ! -z $ZSH_DEBUG ] && printf 'Initializing %s' "${plugin}"
  source "${plugin}" && [ ! -z $ZSH_DEBUG ] && echo ' [DONE]' || [ ! -z $ZSH_DEBUG ] && echo '[FAIL]'
done


for plugin in ${plugin_after_paths[@]}; do
  after_config=${plugin:h}/after-${plugin:t}.zsh
  [[ -f ${after_config} ]] || continue

  [ ! -z $ZSH_DEBUG ] && printf 'Culminating %s' "${plugin}"
  source "${after_config}" && [ ! -z $ZSH_DEBUG ] && echo ' [DONE]' || [ ! -z $ZSH_DEBUG ] && echo '[FAIL]'
done


[ -z $ZSH_DEBUG ] && set +x
