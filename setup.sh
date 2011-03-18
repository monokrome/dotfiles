#!/bin/bash
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
# It will also check for a file called i686 on 32bit machines, or x86_64 on
# 64-bit machines. More platforms can easily by added by creating a
# directory for that platform and providing any of the scripts as executables
# within that directory or any of it's parent directories as supplied in the
# command-line.
#

# A list of executable files that we can attempt to find in platform
# directories. If these exist, they will be executed in this order.
configuration_filenames=(setup setup.sh)

# By default, we install workstations. However, any other arbitrary string can
# be considered.
configuration_type="workstation"

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

if [[ ! -d ${configuration_directory} ]]; then
	# TODO: List the configurations that are provided by this platform.

	echo "The" "${1}" "platform does not provide a" "${configuration_type}" "configuration."
	exit
fi

# TODO: Architecture-specific directories where applicable.

# Let the user know that we are about to attempt a configuration with the platform supplied as
# the specified system directory.
echo "Attempting to configure using the" "${1}" "platform as a" "${configuration_type}"

for configuration_filename in "${configuration_filenames[@]}"; do
	found_files=()

	while IFS= read -d '' -r file; do
		found_files+=("$file")
	done < <(find . -name "${configuration_filename}" -print0)
done

