#! /usr/bin/env bash
# install-tools-development-ubuntu.sh

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
    
    # For Linux Kernel Development
    apt-get -y install --no-install-recommends \
        git make cmake exuberant-ctags 
    
    # For Yocto
    apt-get -y install --no-install-recommends \
        gawk wget git-core subversion diffstat unzip sysstat texinfo build-essential chrpath socat python3 python3-pip \
        xz-utils locales cpio screen tmux sudo iputils-ping iproute2 fluxbox tightvncserver liblz4-tool libzstd-dev \
        zstd file

    # For X11 forwarding
    apt-get -y install --no-install-recommends \
        xauth
EOF
