#! /usr/bin/env bash
# docker-run-helper.sh

docker_run()
{
    if docker ps -a --format '{{.Names}}' | grep -q "^$container_name$"; then
        echo "Container exists..."
        docker container start \
            ${container_name}
        # Only available in swarm
        # docker volume update \
        #     ${container_volumes} \
        #     ${container_name}
        docker container exec -it \
            --user=${container_user} \
            ${container_name} \
            ${container_cmd}
    else
        echo "Container doesn't exists. Creates container..."
        docker container run -it \
            --name ${container_name} \
            ${container_volumes} \
            ${image_name}
    fi
}

# # Get the directory path of the currently executing script
# current_script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# script_to_source="${current_script_dir}/docker-run-helper.sh"

# # Check if the script exists before sourcing it
# if [ -f "$script_to_source" ]; then
#     # Source the script
#     source "$script_to_source"
# else
#     echo "Error: Script to source not found at $script_to_source"
# fi
