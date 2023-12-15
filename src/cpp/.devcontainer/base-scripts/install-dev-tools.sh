#! /usr/bin/env bash
# install-dev-tools.sh

export RUN="sudo -s"

# [Optional] Uncomment this section to install additional OS packages.
# HB: 1st/2nd: For Linux Kernel Development
$RUN << EOF
    apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install build-essential cmake cppcheck valgrind clang lldb llvm gdb \
    && apt-get -y install --no-install-recommends \
            git ctags make cmake
EOF
