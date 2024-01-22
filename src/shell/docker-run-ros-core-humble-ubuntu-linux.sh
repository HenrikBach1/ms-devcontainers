#! /usr/bin/env bash
# source C:\Users\henri\OneDrive\Projects\DevContainers\github\henrikbach1\ms-devcontainers\src\shell\
# source ~/projects/DevContainers/github/henrikbach1/ms-devcontainers/src/shell/
    # docker-run-ros-core-humble-ubuntu.sh

docker run -it \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /mnt/wslg:/mnt/wslg \
    -e DISPLAY=:0 \
    -e WAYLAND_DISPLAY=wayland-0 \
    -e XDG_RUNTIME_DIR=/mnt/wslg/runtime-dir \
    -e PULSE_SERVER=/mnt/wslg/PulseServer \
    --name ros-core-humble \
    --volume "${HOME}/projects":"/projects" \
    ros:humble-ros-core
    # --volume "/mnt/c/Users/${USER}/OneDrive/Projects":"/projects"
