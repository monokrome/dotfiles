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
	# TODO: Provide a list of supported platforms.

	echo "You must supply a platform to install for as an argument in the following format:"
	echo "./setup.sh <platform>"

	exit
fi

# Provide an error if an unsupported platform is supplied as an argument to this application
if [[ ! -d $1 ]]; then
	# TODO: Provide a list of supported platforms.

	echo "$1 is not a supported platform."

	exit
fi

configuration_directory="${1}/${configuration_type}"
configuration_system="$(expr "${configuration_directory}" : '\([^/]*\)/.*')"

if [[ ! -d ${configuration_directory} ]]; then
	# TODO: List the configurations that are provided by this platform.

	echo "The" "${1}" "platform does not provide a" "${configuration_type}" "configuration."
	exit
fi

# Let the user know that we are about to attempt a configuration with the platform supplied as
# the specified system directory.
echo "Attempting to configure using the" "${1}" "platform as a" "${configuration_type}"

for configuration_filename in "${configuration_filenames[@]}"; do
	IFS=/ read -ra dirs <<< "${configuration_directory}"

	current_directory="."

	for next_directory in "${dirs[@]}"; do
		current_directory="${current_directory}/${next_directory}"

		current_setup_file="${current_directory}/${configuration_filename}"

		if [[ -f "${current_setup_file}" ]]; then
			command "${current_setup_file}"
		fi
	done

done

