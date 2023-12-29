# -e DISPLAY=<host-ip>:0 -v /tmp/.X11-unix:/tmp/.X11-unix

container_user=pokyuser
container_name="crops-yocto-poky"
container_volumes=" -v "C:/Users/${USER}":"/mnt/${USER}" -v "C:/Projects":"/projects" "
# container_cmd="bash -c 'cd ~ && exec bash'"
container_cmd="/bin/bash"
image_name="crops/poky:latest"

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
