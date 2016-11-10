sourceall() {
    for filename in $@; do
        source "$filename"
    done
}


sourceall ~/.config/zsh/private/*.zsh  # TODO: Encrypt these.
sourceall ~/.config/zsh/*.zsh
sourceall ~/.config/zsh/plugins/*.zsh


