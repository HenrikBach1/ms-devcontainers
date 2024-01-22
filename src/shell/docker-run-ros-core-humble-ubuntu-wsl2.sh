#! /usr/bin/env bash
# source C:\Users\henri\OneDrive\Projects\DevContainers\github\henrikbach1\ms-devcontainers\src\shell\
# source ~/projects/DevContainers/github/henrikbach1/ms-devcontainers/src/shell/
    # docker-run-ros-core-humble-ubuntu-wsl2.sh

# Windows and WSL with x11 apps in docker?:
X11_CONTAINER_ARGS=" \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /mnt/wslg:/mnt/wslg \
    -e DISPLAY=:0 \
    -e WAYLAND_DISPLAY=wayland-0 \
    -e XDG_RUNTIME_DIR=/mnt/wslg/runtime-dir \
    -e PULSE_SERVER=/mnt/wslg/PulseServer \
    "

include_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${include_dir}/docker-run-helper.sh"
# docker_run

docker \
    run -it \
    ${X11_CONTAINER_ARGS} \
    --name ros-core-humble \
    --volume "/mnt/c/Users/${USER}/OneDrive/Projects":"/projects" \
    ros:humble-ros-core
