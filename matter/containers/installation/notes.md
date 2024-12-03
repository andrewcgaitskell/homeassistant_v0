# compose

sudo docker compose up -d --build

# logs

sudo docker logs reactjs_container

# npm 

npm init react-app reactjs


# docker useful

    To delete all containers including its volumes use,
    
    docker rm -vf $(docker ps -aq)
    To delete all the images,
    
    docker rmi -f $(docker images -aq)


