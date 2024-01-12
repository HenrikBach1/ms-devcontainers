#! /usr/bin/env bash
# docker-run-yocto-crops-poky-windows.sh

container_user=pokyuser
container_name="crops-yocto-poky"
    # --volume "C:/Users/${USER}":"/mnt/${USER}" 
container_volumes=" \
    --volume "C:/Projects":"/projects" \
    --volume "C:/Users/${USER}/OneDrive/Projects/yocto/projects":"/projects/yocto/projects" \
    --volume "C:/Users/${USER}/OneDrive/Projects/yocto/poky":"/projects/yocto/poky" \
    --volume "C:/Users/${USER}/OneDrive/Projects/yocto/shared":"/projects/yocto/shared" \
    "
container_cmd="/bin/bash"
image_name="crops/poky:latest"

current_script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${current_script_dir}/docker-run-helper.sh"

docker_run
