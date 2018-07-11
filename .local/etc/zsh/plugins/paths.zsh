initial_path=${PATH}


setup_paths() {
    append_path=''

    if [[ -d ./bin ]]; then
      printf 'appending ./bin to PATH\n' > /dev/stderr
      append_path=${append_path}:$(pwd)/bin
    fi

    export PATH=${append_path}:${initial_path}
}


chpwd_functions=(
  ${chpwd_functions[@]}
  "setup_paths"
)
