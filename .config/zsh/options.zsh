# Automatically cd into directories when typing their names
setopt autocd


# Smart globbing
setopt extendedglob
setopt completeinword


# Notify?
setopt notify


# These are the worst
setopt nobeep


# Remind me when I'm not typing properly
setopt correct


# Ignore duplicates and share history
setopt hist_ignore_dups
setopt share_history


# Don't ask me if I'm sure that I want completions
zstyle ':completion:*' list-prompt ''
