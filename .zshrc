#!/usr/bin/env zsh


[ ! -z $ZSH_DEBUG ] && set -x


export ZSH_CONFIG_PATH
export ZSH_PLUGIN_PATH


ZSH_CONFIG_PATH=${HOME}/.config/zsh
ZSH_PLUGIN_PATH=${ZSH_CONFIG_PATH}/external/**(N)


config_plugin_prefix='configure_'
config_path=${ZSH_CONFIG_PATH}/etc
local_path=${ZSH_CONFIG_PATH}/local


setopt extended_glob
config_plugin_paths=(${config_path}/${config_plugin_prefix}*.zsh(.N))
unsetopt extended_glob


with_debug() {
  [ ! -z "${ZSH_DEBUG}" ] && $@
}


-execute() {
  with_debug printf '. %s ' "$@"
  source "$@" && with_debug echo " [OKAY]" || with_debug echo " [FAIL]"
}


-source_all() {
  for filename in $@; do
    -execute "${filename}"
  done
}


for config_script in ${config_plugin_paths[@]}; do
  basename=${config_script:t}
  script_name=${basename##${config_plugin_prefix}}

  source_path="${config_path}/${script_name}"
  dest_path="${local_path}/${script_name}"

  # Skip configuration if already done, or if no source plugin found
  [[ ! -e ${source_path} || -e ${dest_path} ]] && continue

  alias install_local_plugin="ln -s '${source_path}' '${dest_path}'"
  alias ignore_local_plugin="touch '${dest_path}'"

  -execute ${config_script}

  unalias install_local_plugin
  unalias ignore_local_plugin
done


setopt extended_glob
local_plugin_paths=(${local_path}/*.zsh(-.N))
plugin_paths=(${ZSH_CONFIG_PATH}/{plugins,external}/(^after-)*.zsh(-.N))
plugin_after_paths=(${ZSH_CONFIG_PATH}/{external,plugins}/after-*.zsh(-.N))
unsetopt extended_glob


-source_all ${local_plugin_paths[@]}
-source_all ${plugin_paths[@]}
-source_all ${plugin_after_paths[@]}


[ -z $ZSH_DEBUG ] && set +x
