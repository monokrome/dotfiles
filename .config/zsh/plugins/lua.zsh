[[ -z $LUAROCKS_PATH ]] && export LUAROCKS_PATH=$HOME/.luarocks
[[ -e $LUAROCKS_PATH ]] && path=($LUAROCKS_PATH $path)
