alias clean='find . -iname \*.pyc -exec rm {} \;'
alias vim=nvim
alias freeze="pip freeze | grep -v neovim"


# Because OSX is WTF
if [[ -d /usr/local/opt/openssl/include ]]; then
    alias pip='LDFLAGS="-I/usr/local/opt/openssl/include -L/usr/local/opt/openssl/lib" pip'
fi
