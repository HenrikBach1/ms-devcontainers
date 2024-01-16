#! /usr/bin/env bash
echo docker-run-ubuntu2004-linux.sh

container_name="cpp-kernel-ubuntu2004"
container_volumes=" \
    -v "${HOME}":"/mnt/${USER}" \
    -v "${HOME}/projects":"/projects" \
    "
container_cmd="bash" # TODO: Not viable in script, but on cli: -c 'cd ~ && exec bash'"
    # docker container exec -it --user=pokyuser cpp-kernel-ubuntu2204 bash -c 'cd ~ && exec bash'
image_name="ubuntu:20.04"

include_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${include_dir}/docker-run-helper.sh"

docker_run

# TODO: If below problem persists with: 
# How do i make sure locale 'en_US.UTF-8' is available on your ubuntu system
# How to fix invalid locale settings LANG=en_US.UTF8

# Generating answers for you…

# I’m sorry to hear that. Here’s how you can fix the error:

# The error message indicates that the locale settings are invalid. You can try the following steps to fix it:

# Open a terminal window.
# Run the command sudo nano /etc/locale.gen to open the locale configuration file.
# Uncomment the line en_US.UTF-8 UTF-8 by removing the # character at the beginning of the line.
# Save the file and exit the editor.
# Run the command sudo locale-gen to generate the new locale settings.
# Run the command sudo update-locale LANG=en_US.UTF-8 to update the locale settings.
# If you still encounter the same error, you can try the following:

# Open the file /etc/default/locale with a text editor.
# Add the following lines to the file:
# LANG=en_US.UTF-8
# LC_ALL=en_US.UTF-8

# Save the file and exit the editor.
# Run the command sudo update-locale LANG=en_US.UTF-8 to update the locale settings.
# I hope this helps!
