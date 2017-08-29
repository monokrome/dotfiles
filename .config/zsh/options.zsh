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


# Don't enable history saving unless we can write to in-memory files :)
if [[ -e /dev/shm ]]; then
    export SAVEHIST=10000
    export HISTFILE=/dev/shm/.${USER}.zsh_history
else
    export SAVEHIST=0
fi

setopt append_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_functions
setopt hist_reduce_blanks
setopt share_history
