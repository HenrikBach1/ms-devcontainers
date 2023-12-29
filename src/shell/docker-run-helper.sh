#! /bin/bash

docker_run()
{
    if docker ps -a --format '{{.Names}}' | grep -q "^$container_name$"; then
        echo "Container exists..."
        docker start ${container_name}
        docker exec -it \
            --user=${container_user} \
            ${container_name} \
            ${container_cmd}
    else
        echo "Container doesn't exists..."
        docker run -it \
            --name ${container_name} \
            ${container_volumes} \
            ${image_name}
    fi
}
