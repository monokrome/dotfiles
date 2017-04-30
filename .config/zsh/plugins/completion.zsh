#!/usr/bin/env zsh


autoload -U compinit
autoload -U colors


# Initialize completion system
compinit -DC


# Breakdown of style completion fields, for reference:
# :completion - Literal string, always the same.
# :function   - Name of a specific widget function being used.
# :completer  - The specific completer being used.
# :command    - Command name (or sometimes a special string for the completer)
# :argument   - Which command-line argument is being completed
# :tag        - The tag which we are currently completing
#
# Example matching "..." in `dvips -o ...`: 
# :completion::complete:dvips:option-o-1:files


# Do case-insensitive matching, but prefer exact matches
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


# Use menu selection for completions
zstyle ':completion:*' menu select


# If I hit tab I want them. Don't ask "Are you sure?"
zstyle ':completion:*' list-prompt ''


# Formatting and message
zstyle ':completion:*'              completer    _expand _complete _correct _approximate
zstyle ':completion:*'              group-name   ''
zstyle ':completion:*'              verbose      yes
zstyle ':completion:*:corrections'  format '     %B%d (errors: %e)%b'
zstyle ':completion:*:descriptions' format "     %F{yellow}%B--- %d%b%f"
zstyle ':completion:*:warnings'     format "     %F{yellow}--- No matches found.%f"
zstyle ':completion:*:warnings'     format "     %F{yellow}--- No matches found.%f"
