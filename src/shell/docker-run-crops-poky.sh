#! /usr/bin/bash
# docker-run-crops-poky.sh

# docker run --rm -it -v myvolume:/workdir crops/poky --workdir=/workdir
docker run -it -v "C:/Users/${USER}":"/mnt/${USER}" -v "C:/Projects":"/projects" --name crops-yocto-poky crops/poky:latest
