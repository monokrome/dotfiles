#!/bin/bash

shared_source common.sh
shared_source common_configurations.sh

add_configuration .Xresources
add_configuration .xinitrc
add_configuration .xbindkeysrc

add_configuration bin/brightness

add_configuration .fonts/TerminusBold.ttf
add_configuration .fonts/TerminusMedium.ttf
add_configuration .fonts/TerminusMediumItalic.ttf

# A little not for the Linux people!
echo
info 'This machine is Linux. You may need to logout for some changes to take affect.'

