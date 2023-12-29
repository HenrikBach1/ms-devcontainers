# -e DISPLAY=<host-ip>:0 -v /tmp/.X11-unix:/tmp/.X11-unix

container_name="crops-yocto-poky"
image_name="crops/poky:latest"

if docker ps -a --format '{{.Names}}' | grep -q "^$container_name$"; then
    echo "Container exists..."
    docker start ${container_name}
    docker exec -it \
        --user=pokyuser ${container_name} \
        bash -c 'cd ~ && exec bash'
else
    echo "Container doesn't exists..."
    docker run -it \
        --name ${container_name} \
        -v "C:/Users/${USER}":"/mnt/${USER}" -v "C:/Projects":"/projects" \
        ${image_name}
fi
