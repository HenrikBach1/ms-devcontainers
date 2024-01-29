#! /usr/bin/env bash
# ./install-tools-development-ubuntu.sh

export RUN="sudo -s"
source /etc/os-release

if [[ ! $ID_LIKE == *"debian"* ]]; then
    echo "This script only supports debian and its deriviatives!"
    return 1
fi

if [[ "${USER}" == "" ]]; then
        if [[ ! ${HOME} == "" ]]; then
            export USER=$(basename "$HOME")
        else
            echo "Cannot state which user is running in the terminal"
            return 1
        fi
fi

if [[ 1 == 1
    ]]; then
        if [[ "${USER}" == "root" 
                && $ID_LIKE == *"debian"*
            ]]; then
                if ! type "sudo" &> /dev/null; then
                    # Assume first time installation
                    apt update -y
                    apt install -y sudo
                fi
        fi
fi

$RUN << EOF
    # CPP Development and debuging in general
    apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install \
        build-essential cmake cppcheck valgrind clang lldb llvm gdb \
        nano less
    
    # Linux Kernel Development
    apt-get -y install --no-install-recommends \
        git make cmake exuberant-ctags 
    
    # Yocto Development: HOSTTOOLS
    apt-get -y install --no-install-recommends \
        gawk wget git-core subversion diffstat unzip sysstat texinfo build-essential chrpath socat python3 python3-pip \
        xz-utils locales cpio screen tmux sudo iputils-ping iproute2 fluxbox tightvncserver liblz4-tool libzstd-dev \
        zstd file

    # X11 forwarding
    apt-get -y install --no-install-recommends \
        xauth
EOF
