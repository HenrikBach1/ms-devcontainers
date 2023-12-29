# -e DISPLAY=<host-ip>:0 -v /tmp/.X11-unix:/tmp/.X11-unix
docker run -it --name=cpp-kernel-ubuntu2204 -v "C:/Users/henri":"/mnt/henri" -v "C:/Projects":"/projects" ubuntu:22.04 /bin/bash