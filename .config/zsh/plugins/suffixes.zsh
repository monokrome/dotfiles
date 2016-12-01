suffix_file="${ZSH_CONFIG_PATH}/suffixes"


if [[ -f "${suffix_file}" ]]; then
    while read -r suffix; do
        if [[ ! -z "$suffix" ]]; then
            alias_arguments=$(echo "$suffix" | sed 's/ /=/')
            alias -s ${alias_arguments}
        fi
    done < ${suffix_file}
fi
