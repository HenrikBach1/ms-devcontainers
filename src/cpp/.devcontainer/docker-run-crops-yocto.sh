#! /usr/bin/bash

# docker run --rm -it -v myvolume:/workdir crops/poky --workdir=/workdir
docker run -it -v "C:/Users/henri/OneDrive/Projects":"/projects" --name crops-yocto-poky crops/poky:latest
