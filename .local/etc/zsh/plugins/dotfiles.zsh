# Load completion plugin
autoload -U compinit

# Create a git alias called `dot` for managing dotfiles
alias dot='git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'

# Use git autocompletion with the dot alias
compdef _git dot

