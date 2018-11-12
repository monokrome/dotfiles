#!/usr/bin/env zsh

suffix_file="${ZSH_CONFIG_PATH}/suffixes"

__suffix_init() {
  while read -r suffix; do
    [[ -z "$suffix" ]] && continue
    alias -s $(echo "$suffix" | sed 's/ /=/')
  done < ${suffix_file}
}

[[ -f "${suffix_file}" ]] && __suffix_init
