#!/usr/bin/env zsh


setup_xbps_packaging() {
    alias pkg="sudo xbps-install -S"
    alias pkgrm="sudo xbps-remove"
    alias pkgup="sudo xbps-install -Su"
    alias pkgls="xbps-query -Rs"
}


setup_apt_packaging() {
    alias pkg="sudo apt-get install -y"
    alias pkgrm="sudo apt-get uninstall --purge"
    alias pkgup="sudo apt-get update -yy && sudo apt-get upgrade -yy"
    alias pkgls="apt-cache search"
}


setup_homebrew_packaging() {
    alias pkg="brew install"
    alias pkgrm="brew uninstall"
    alias pkgup="brew update"
    alias pkgls="brew search"
}


setup_packages() {
    which xbps-install > /dev/null 2> /dev/null && setup_xbps_packaging && return
    which apt-get > /dev/null 2> /dev/null && setup_apt_packaging && return
    which brew > /dev/null 2> /dev/null && setup_homebrew_packaging && return
}


setup_packages
