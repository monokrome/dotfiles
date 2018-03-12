#!/usr/bin/env sh

export PATH

for new_path in .*/bin; do
  PATH="${HOME}/${new_path}:${PATH}"
done
