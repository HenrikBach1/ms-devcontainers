#! /usr/bin/env bash
# install-tools-debian.sh

export RUN="sudo -s"

# [Optional] Uncomment this section to install additional OS packages.
# HB: 1st: For CPP Development
# HB: 2nd: For Linux Kernel Development
# HB: 3rd/4th: For Yocto
# HB: 5th: For X11 forwarding
$RUN << EOF
    apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install \
        build-essential cmake cppcheck valgrind clang lldb llvm gdb \
    && apt-get -y install --no-install-recommends \
        git ctags make cmake \
    && apt-get -y install --no-install-recommends \
        gawk wget git-core subversion diffstat unzip sysstat texinfo build-essential chrpath socat python python3 python3-pip \
        xz-utils locales cpio screen tmux sudo iputils-ping iproute2 fluxbox tightvncserver \
    && apt-get -y install --no-install-recommends \
        liblz4-tool libzstd-dev \
    && apt-get -y install --no-install-recommends \
        xauth
EOF
