#! /usr/bin/env bash
echo docker-run-yocto-crops-poky-linux.sh

include_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${include_dir}/docker-run-helper.sh"
source "${include_dir}/path"

container_user=pokyuser
container_name="crops-yocto-poky"
container_volumes=" \
    -v "${HOME}":"/mnt/${USER}" \
    -v "${HOME}/projects":"/projects" \
    "
container_cmd="/bin/bash"
image_name="crops/poky:latest"

docker_run
