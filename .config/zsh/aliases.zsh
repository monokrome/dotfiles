alias clean='find . -iname \*.pyc -or -iname .DS_Store -or -iname Thumbds.db -exec rm {} \;'
alias dot='git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'
alias freeze="pip freeze | grep -v neovim"
alias vim=nvim
alias avi='get json $@'


# Because OSX is WTF
if [[ -d /usr/local/opt/openssl/include ]]; then
    alias pip='LDFLAGS="-I/usr/local/opt/openssl/include -L/usr/local/opt/openssl/lib" pip'
fi
