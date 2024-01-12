#! /usr/bin/env bash
echo docker-run-yocto-crops-poky-windows.sh

if [[ $debug_enable == true ]]; then
    set -vx
else
    set +vx
fi

include_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${include_dir}/docker-run-helper.sh"
source "${include_dir}/path"

container_user=pokyuser
container_name="crops-yocto-poky"
    # --volume "C:/Users/${USER}":"/mnt/${USER}" 
container_volumes=" \
    --volume $(path-dos2unix "C:/Projects"):/projects \
    --volume $(path-dos2unix "C:/Users/${USER}/OneDrive/Projects/yocto/projects"):/projects/yocto/projects \
    --volume $(path-dos2unix "C:/Users/${USER}/OneDrive/Projects/yocto/poky"):/projects/yocto/poky \
    --volume $(path-dos2unix "C:/Users/${USER}/OneDrive/Projects/yocto/shared"):/projects/yocto/shared \
    "
container_cmd="/bin/bash"
image_name="crops/poky:latest"

docker_run
