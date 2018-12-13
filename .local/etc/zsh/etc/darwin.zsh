#!/usr/bin/env zsh


alacritty_config_path="${HOME}/.local/etc/alacritty/"
alacritty_standard_path="${alacritty_config_path}standard.yml"
alacritty_darwin_path="${alacritty_config_path}darwin.yml"

alacritty_config_file="${alacritty_config_path}alacritty.yml"


install_alacritty_configuration() {
  cat "${alacritty_standard_path}" > "${alacritty_config_file}"
  cat "${alacritty_darwin_path}" >> "${alacritty_config_file}"
}


[[ ! -e "${alacritty_config_file}" ]] && install_alacritty_configuration
