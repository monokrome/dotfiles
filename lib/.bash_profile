# Any directories that should additionally be treated as prefixes.
additional_prefixes=(
  "/usr/local"
  "${HOME}"
)

# Since some things install other things in silly places
extra_paths=(
  "./bin"
  "./node_modules/.bin"
  "/usr/local/share/python"
)

bash_completions=(
  "/usr/local/etc/bash_completion"
)

# Specific additions to PATH
for next_path in ${extra_paths[@]}; do
  PATH="${next_path}:${PATH}"
done

# Any additional full installation prefixes.
for next_prefix in ${additional_prefixes[@]}; do
  if [[ -d "${next_prefix}/bin" ]]; then
    PATH="${next_prefix}/bin:${PATH}"
  fi
done

# Any completion scripts that might need included
for completion in ${bash_completions[@]}; do
  if [[ -f "${completion}" ]]; then
    source "${completion}"
  fi
done

# Thanks to @kroogs for the idea of making the text red on errors :D

# This is a global reference to be used in order to know the last return
# code from within functions.
last_response_code=$?

# Formats the provided text into something a bit more striking.
error_text () { echo "\033[31m${@}\033[0m"; }

# Generates our PS1 when passed the last program's response code, and
# whatever text we want in the PS1.
make_PS1 () {
  PS1_git=$(__git_ps1 "(%s) ")

  if [ ${last_response_code} = 0 ]; then
    echo "${PS1_git}${@} ";
  else
    echo -e "${PS1_git}`error_text ${@}` ";
  fi
}

function git_diff() {
  git diff --no-ext-diff -w "$@" | vim -R -
}

# A PS1.
export PS1='`last_response_code=$?;make_PS1 \W`'
export EDITOR='vim'

source $HOME/.config/cli-shims/*.sh

function ls() {
  clear
  command ls $@
  echo
}

