#! /usr/bin/env bash
# install-dev-tools.sh

export RUN="sudo -s"

# [Optional] Uncomment this section to install additional OS packages.
# HB: 1st/2nd: For Linux Kernel Development
# HB: 3rd: For Yocto
$RUN << EOF
    apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install build-essential cmake cppcheck valgrind clang lldb llvm gdb \
    && apt-get -y install --no-install-recommends \
            git ctags make cmake \
    && apt-get -y install --no-install-recommends \
            wget git-core unzip make gcc g++ build-essential subversion sed autoconf automake texi2html texinfo coreutils diffstat python-pysqlite2 docbook-utils libsdl1.2-dev libxml-parser-perl libgl1-mesa-dev libglu1-mesa-dev xsltproc desktop-file-utils chrpath groff libtool xterm gawk fop
EOF
