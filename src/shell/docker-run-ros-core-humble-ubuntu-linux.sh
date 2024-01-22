#! /usr/bin/env bash
# source C:\Users\henri\OneDrive\Projects\DevContainers\github\henrikbach1\ms-devcontainers\src\shell\
# source ~/projects/DevContainers/github/henrikbach1/ms-devcontainers/src/shell/
    # docker-run-ros-core-humble-ubuntu-linux.sh

xhost +
X11_CONTAINER_ARGS=" \
    --volume $HOME/.Xauthority:/root/.Xauthority:rw \
    -e DISPLAY=$DISPLAY \
    --net=host \
    "

# include_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# source "${include_dir}/docker-run-helper.sh"
# # docker_run

    # --rm 
docker \
    run -it \
    ${X11_CONTAINER_ARGS} \
    --volume "${HOME}/projects":"/projects" \
    ros:humble-ros-core
