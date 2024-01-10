#! /usr/bin/env bash
# source C:\Users\henri\OneDrive\Projects\DevContainers\github\henrikbach1\ms-devcontainers\src\shell\
    # docker-run-ros-core-humble.sh

docker run -it \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /mnt/wslg:/mnt/wslg \
    --volume "C:/Projects":"/projects" \
    -e DISPLAY=:0 \
    -e WAYLAND_DISPLAY=wayland-0 \
    -e XDG_RUNTIME=/mnt/wslg/runtime-dir \
    -e PULSE_SERVER=/mnt/wslg/PulseServer \
    ros:humble-ros-core
