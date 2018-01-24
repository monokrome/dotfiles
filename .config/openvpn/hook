#!/usr/bin/env bash

# Rename this to `$vpn_state` to be more semantically useful. `$script_type` is
# a really weird name.
vpn_state=$script_type

case $vpn_state in
  up)
    # Create a result array for our final list of namservers
    nameservers=()
    search=()

    # Loop through every variable name w/ that matches foreign_option_*
    for option in ${!foreign_option_*}; do
      # Get value of our option as an array
      values=(${!option})

      [[ ${values[0]} != 'dhcp-option' ]] && continue
      [[ ${values[1]} == 'DNS' ]] && nameservers+=(${values[2]})
      [[ ${values[2]} = DOMAIN* ]] && search+=(${values[2]})

      for nameserver in $nameservers; do
        printf 'nameserver %s\n' $nameserver | resolvconf -a $dev
      done

      for domain in $search; do
        printf 'search %s\n' $domain | resolvconf -a $dev
      done
    done
    ;;

  down)
    resolvconf -d $dev
    ;;
esac
