## set environmental variables

# remember to copy the .env file into create before running this

cp .env /home/home_user/Code/home_podman/mariadb/.env

## set the variables for the containers
source setenv.sh
source /home/home_user/Code/home_podman/mariadb/createinitsql.sh

## mariadb image

cd /home/home_user/Code/home_podman/mariadb

rm -rf /home/home_user/home_data/mariadb
mkdir /home/home_user/home_data/mariadb

podman stop mariadb_container
podman rm mariadb_container
podman rmi mariadb_image

podman build \
--build-arg=BUILD_ENV_UID=${ENV_UID} \
--build-arg=BUILD_ENV_USERNAME=${ENV_USERNAME} \
--build-arg=BUILD_ENV_GID=${ENV_GID} \
--build-arg=BUILD_ENV_GROUPNAME=${ENV_GROUPNAME} \
--build-arg=BUILD_ENV_MARIADB_USER=${ENV_MARIADB_USER} \
--build-arg=BUILD_ENV_MARIADB_PASSWORD=${ENV_MARIADB_PASSWORD} \
--build-arg=BUILD_ENV_MARIADB_ROOT_PASSWORD=${ENV_MARIADB_ROOT_PASSWORD} \
--build-arg=BUILD_ENV_MARIADB_DATABASE=${ENV_MARIADB_DATABASE} \
-t mariadb_image .

##-v /HOST-DIR:/CONTAINER-DIR

## Jupyter

cd /home/home_user/Code/home_podman/jupyter_2

podman stop jupyter_container
podman rm jupyter_container

podman rmi jupyter_image

podman build \
--build-arg=BUILD_ENV_UID=${ENV_UID} \
--build-arg=BUILD_ENV_USERNAME=${ENV_USERNAME} \
--build-arg=BUILD_ENV_GID=${ENV_GID} \
--build-arg=BUILD_ENV_GROUPNAME=${ENV_GROUPNAME} \
-f Dockerfile -t jupyter_image

cd /home/home_user/Code/home_podman/reactjs

podman stop reactjs_container
podman rm reactjs_container

podman rmi reactjs_image_root
podman rmi reactjs_image_user

podman build \
-f Dockerfile_root -t reactjs_image_root

podman build \
--build-arg=BUILD_ENV_UID=${ENV_UID} \
--build-arg=BUILD_ENV_USERNAME=${ENV_USERNAME} \
--build-arg=BUILD_ENV_GID=${ENV_GID} \
--build-arg=BUILD_ENV_GROUPNAME=${ENV_GROUPNAME} \
-f Dockerfile_user -t reactjs_image_user

## mosquitto image

cd /home/home_user/Code/home_podman/mosquitto

podman stop mosquitto_container
podman rm mosquitto_container

podman rmi mosquitto_image:latest

podman build \
--build-arg=BUILD_ENV_UID=${ENV_UID} \
--build-arg=BUILD_ENV_USERNAME=${ENV_USERNAME} \
--build-arg=BUILD_ENV_GID=${ENV_GID} \
--build-arg=BUILD_ENV_GROUPNAME=${ENV_GROUPNAME} \
-f Dockerfile -t mosquitto_image .

## dash image

cd /home/home_user/Code/home_podman/dash

podman stop dash_container
podman rm dash_container

podman rmi dash_image:latest

podman build \
--build-arg=BUILD_ENV_UID=${ENV_UID} \
--build-arg=BUILD_ENV_USERNAME=${ENV_USERNAME} \
--build-arg=BUILD_ENV_GID=${ENV_GID} \
--build-arg=BUILD_ENV_GROUPNAME=${ENV_GROUPNAME} \
-f Dockerfile -t dash_image .

