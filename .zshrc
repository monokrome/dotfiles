export ZSH_CONFIG_PATH=$HOME/.config/zsh


sourceall() {
    for filename in $@; do
        source "$filename"
    done
}


sourceall ${ZSH_CONFIG_PATH}/*.zsh(N)
sourceall ${ZSH_CONFIG_PATH}/plugins/*.zsh(N)
