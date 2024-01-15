#! /usr/bin/env bash
echo docker-run-ubuntu2204-linux.sh

container_name="cpp-kernel-ubuntu2204"
container_volumes=" \
    -v "${HOME}":"/mnt/${USER}" \
    -v "${HOME}/projects":"/projects" \
    "
container_cmd="bash" # TODO: Not viable in script, but on cli: -c 'cd ~ && exec bash'"
    # docker container exec -it --user=pokyuser cpp-kernel-ubuntu2204 bash -c 'cd ~ && exec bash'
image_name="ubuntu:22.04"

include_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${include_dir}/docker-run-helper.sh"

docker_run
