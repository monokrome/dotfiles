System-Specific Configuration Plugins
-------------------------------------

This directory exists as a way to configure your shell for specific systems.
There are a number of specific files which will be sourced here, which are
expected to detect information about your system and create *local* plugins in
the `local` in the repository.

The expected pattern here is to create small scripts which run quick checks
against the system. These should be as fast as possible, as they will can
down shell creation if not. If the detection is successful, ZSH will install a
local plugin for you.

The directory structure is defined as follows:

    - /
      - etc/
        - configure_example.zsh
        - example.zsh
      - local/
        - example.zsh -> ../etc/example.zsh

In the previously outlined case, we will source all files matching
~~/etc/configure_*.zsh~~. For each one of these, we will then check if
*local* has a plugin installed which matches the pattern. For instance,
`source etc/configure_example.zsh` will only be executed if
~~local/example.zsh~~ doesn't exist yet.

The sourced script has an option to execute `install_local_plugin` which
will create a symlink in the *local* directory.

If the plugin shouldn't be installed, the user wants to ensure that the
configuration script will not be sourced again. In this case, the script
should execute `ignore_local_plugin` which will insert an empty file where
the plugin would have been installed.
