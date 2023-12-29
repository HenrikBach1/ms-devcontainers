# -e DISPLAY=<host-ip>:0 -v /tmp/.X11-unix:/tmp/.X11-unix
docker run -it --name=cpp-kernel-ubuntu2204 -v "${HOME}":"/mnt/${USER}" -v "${HOME}/projects":"/projects" ubuntu:22.04 /bin/bash