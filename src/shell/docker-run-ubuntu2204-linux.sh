# -e DISPLAY=<host-ip>:0 -v /tmp/.X11-unix:/tmp/.X11-unix

container_user=pokyuser
container_name="cpp-kernel-ubuntu2204"
container_volumes=" -v "${HOME}":"/mnt/${USER}" -v "${HOME}/projects":"/projects" "
container_cmd="bash -c 'cd ~ && exec bash'"
image_name="ubuntu:22.04"

# Get the directory path of the currently executing script
current_script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Construct the path to the script you want to source
script_to_source="${current_script_dir}/docker-run-helper.sh"

# Check if the script exists before sourcing it
if [ -f "$script_to_source" ]; then
    # Source the script
    source "$script_to_source"
else
    echo "Error: Script to source not found at $script_to_source"
fi

docker_run
