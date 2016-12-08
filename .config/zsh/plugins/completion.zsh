#!/usr/bin/env zsh


autoload -U compinit && compinit


# Do case-insensitive matching, but prefer exact matches
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


# Use menu selection for completions
zstyle ':completion:*' menu select

# Don't ask me if I'm sure that I want completions
zstyle ':completion:*' list-prompt ''

# Formatting and message
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "${fg[yellow]}%B--- %d%b"
zstyle ':completion:*:warnings' format "${fg[red]}No matches found.$reset_color"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''
