## mariadb image

cd /home/home_user/Code/home_podman/mariadb

rm -rf /home/home_user/home_data/mariadb
mkdir /home/home_user/home_data/mariadb

podman stop mariadb_container
podman rm mariadb_container
podman rmi mariadb_image

source createinitsql.sh

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

