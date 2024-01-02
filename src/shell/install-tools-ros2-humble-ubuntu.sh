#! /usr/bin/env bash
# install-tools-ubuntu.sh

export RUN="sudo -s"

if [[ "${USER}" == "" ]]; then
        if [[ ! ${HOME} == "" ]]; then
            export USER=$(basename "$HOME")
        else
            echo "Cannot state which user is running in the terminal"
            exit 1
        fi
fi

if [[ "${USER}" == "root" ]]; then
    # Suppose first time installation
    apt update -y

    if ! type "sudo" &> /dev/null; then
        apt install -y sudo
    fi
fi

# [Optional] Uncomment this section to install additional OS packages.
$RUN << EOF
    # For CPP Development and debuging in general
    apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install \
        build-essential cmake cppcheck valgrind clang lldb llvm gdb \
        nano less
    
    # For ROS2 - Humble
    # Enable universe repos
    apt install software-properties-common
    add-apt-repository universe
    # Add the ROS 2 GPG key
    apt update -y && sudo apt install curl -y
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
            -o /usr/share/keyrings/ros-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
    # Install ROS 2 packages
    apt update -y
    apt upgrade -y
    apt install -y ros-dev-tools
    apt install -y ros-humble-ros-base
    apt install -y ros-humble-desktop

    # For X11 forwarding
    apt-get -y install --no-install-recommends \
        xauth
EOF
