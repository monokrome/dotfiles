Configuration Manager
=====================

WAT?!
-----

This project provides a simple way to set up your user configurations and make
sure that they stay in sync over multiple machines. It also makes for a nice
configuration backup solution for cases where you lose your files and don't
feel like spending the next week rebuilding everything.

HOW?!
-----

The setup.sh script in the root of this project does all of the hard work for
you, leaving you to simply describe how you want your configurations to be
deployed on each system. At the most basic level, you should only need to run
the following to get your system syncronized with any configurations that you
have set up inside of the repository:

    ./setup.sh

The system works off of a tiered filesystem using the result of running `uname`
(by default) as well as the type of system you are expecting to configure (IE:
workstation, server, etc). By default, the system type is set to 'workstation'
unless otherwise provided. For instance, if you wanted to setup your linux
server configurations on a darwin (OS X) machine - you would run this:

    ./setup.sh linux server

The way that it differentiates your configurations is by simply looking in
subdirectories of the project. If we ran the command to setup a linux server,
the configuration manager would look for the following files within our
repository and execute them in the following order:

    /linux/setup.sh
    /linux/server/setup.sh

It is assumed that these files will tell the system what to install. All
files that are installed are symlinked into this repositories lib
directory. This design is intentional, as it means that updating the
repository will automatically sync any pulled changes on your machine.

The way that the system is told to install files is with functions which
are exported in the root setup.sh file. For instance, adding the following
code to one of your configurations:

    add_configuration .Xdefaults

This will tell your system to symlink ${HOME}/.Xdefaults to this repository's
/lib/.Xdefaults file. If your configuration file is the same as the file
in your repository, then the step will be skipped.

If you ever find yourself needing to share configurations between multiple
machine types, you are able to do so by leveraging the source_shared function.
This function allows you to pull arbitrary files out of the repositorie's
shared directory. For instance, if I had a darwin and linux system - I could
write generic configurations that need to exist on both machines into a file
called `/shared/example.sh`. Now, I am able to simply add this in both
configurations to avoid needing to repeat myself:

    shared_source example.sh

Now, all configurations from example.sh will be applied to anything using that
command. The script is shared between them.

I WANT ONE!!!
-------------

Awesome! I want you to have one, too! Go ahead and pull the `framework` branch
of this repository, and there is a fresh installation waiting for you to make
it beautiful!

