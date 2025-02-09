#! /usr/bin/env bash
echo docker-run-helper.sh

xhost +
X11_CONTAINER_ARGS=" \
    --volume $HOME/.Xauthority:/root/.Xauthority:rw \
    -e DISPLAY=$DISPLAY \
    --net=host \
    "

        # Only available in swarm:
        # docker volume update \
        #     ${container_volumes} \
        #     ${container_name} \
        #
docker_run()
{
    if command -v docker &> /dev/null; then
        if docker ps -a --format '{{.Names}}' | grep -q "^$container_name$"; then
            echo "Container ALREADY exists..."
            docker container start \
                ${container_name} \
            && docker container exec -it \
                --user=${container_user} \
                ${container_name} \
                ${container_cmd}
        else
            echo "Creates container..."
            docker container run -it \
                ${X11_CONTAINER_ARGS} \
                --name ${container_name} \
                ${container_volumes} \
                ${image_name}
        fi
    fi
}

# # Get the directory path of the currently executing script
# include_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# source "${include_dir}/docker-run-helper.sh" # script_to_source =
# docker_run

# # Check if the script exists before sourcing it
# if [ -f "$script_to_source" ]; then
#     # Source the script
#     source "$script_to_source"
# else
#     echo "Error: Script to source not found at $script_to_source"
# fi
