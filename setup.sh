#!/usr/bin/env bash
#
# Should receive a system type to configure. For instance, configuration for
# archlinux should use:
#
#     ./setup.sh linux/arch
#
# This will attempt to execute the following files in first the linux directory,
# followed by the arch directory:
#
#     setup
#     setup.sh
#
# It will also check for these files within a directory with the name returned
# by `uname -r` in each directory. More platforms can easily be added by creating
# a directory for that platform and providing any of the scripts as executables
# within that directory or any of it's parent directories as supplied in the
# command-line.
#

repository_root=$(dirname $0)

# A list of executable files that we can attempt to find in platform
# directories. If these exist, they will be executed in this order.
configuration_filenames=("setup" "setup.sh")

# By default, we install workstations. However, any other arbitrary string can
# be considered when passed as the second argument.
if [[ $2 == "" ]]; then
	configuration_type="workstation"
else
	configuration_type="${2}"
fi

# If this script is not provided a platform to install for, then we have to
# provide an error requesting that one is supplied.
if [[ $1 == "" ]]; then
  operating_system=$(uname | tr '[:upper:]' '[:lower:]')
else
  operating_system=$1
fi

if [[ ! -d ${operating_system} ]]; then
	# TODO: Provide a list of supported platforms.

	echo "Detected platform was:" $operating_system
  echo
  echo "If this is not correct, then you must supply a platform to install for as an argument in the following format:"
	echo "./setup.sh <platform>"

	exit
fi

# Provide an error if an unsupported platform is supplied as an argument to this application
if [[ ! -d $operating_system ]]; then
	# TODO: Provide a list of supported platforms.

	echo "$operating_system is not a supported platform."

	exit
fi

configuration_directory="${repository_root}/${operating_system}/${configuration_type}"
configuration_system="$(expr "${configuration_directory}" : '\([^/]*\)/.*')"

if [[ ! -d ${configuration_directory} ]]; then
	# TODO: List the configurations that are provided by this platform.

	echo "The" "$operating_system" "platform does not provide a" "${configuration_type}" "configuration."
	exit
fi

# Let the user know that we are about to attempt a configuration with the platform supplied as
# the specified system directory.
echo "Attempting to configure using the" $operating_system "platform as a" "${configuration_type}"

for configuration_filename in "${configuration_filenames[@]}"; do
	IFS=/ read -ra dirs <<< "${configuration_directory}"

	for next_directory in "${dirs[@]}"; do
		repository_root="${repository_root}/${next_directory}"

		current_setup_file="${repository_root}/${configuration_filename}"

		if [[ -f "${current_setup_file}" ]]; then
			command "${current_setup_file}"
		fi
	done

done

# Installs a configuration onto the machine
function add_configuration() {
  echo "======> Installing $@"

  ln -s Library/$@ ${HOME}/
}

