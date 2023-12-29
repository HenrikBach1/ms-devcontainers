#! /usr/bin/env bash
# setup.sh

alias git-bash=$(cygpath.exe -u "C:\Program Files\Git\git-bash.exe")

export VAGRANT_VAGRANTFILE=$(cygpath -u "C:\Users\henri\OneDrive\Projects\vagrant\hyper-v\ubuntu\Vagrantfile")
export VAGRANT_DEFAULT_PROVIDER=hyperv
