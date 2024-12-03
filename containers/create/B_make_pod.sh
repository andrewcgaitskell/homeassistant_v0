## set environment variables

source setenv.sh

podman stop mariadb_container
podman rm mariadb_container

podman stop jupyter_container
podman rm jupyter_container

podman stop reactjs_container
podman rm reactjs_container

podman stop mosquitto_container
podman rm mosquitto_container

podman stop dash_container
podman rm dash_container

podman pod stop home_pod
podman pod rm home_pod

uid=${ENV_UID} ##1001
gid=${ENV_GID} ##1002

subuidSize=$(( $(podman info --format "{{ range \
   .Host.IDMappings.UIDMap }}+{{.Size }}{{end }}" ) - 1 ))
subgidSize=$(( $(podman info --format "{{ range \
   .Host.IDMappings.GIDMap }}+{{.Size }}{{end }}" ) - 1 ))


podman pod create \
--name home_pod \
--infra-name infra_home_pod \
--network bridge \
--uidmap 0:1:$uid \
--uidmap $uid:0:1 \
--uidmap $(($uid+1)):$(($uid+1)):$(($subuidSize-$uid)) \
--gidmap 0:1:$gid \
--gidmap $gid:0:1 \
--gidmap $(($gid+1)):$(($gid+1)):$(($subgidSize-$gid)) \
--publish 9000:9000 \
--publish 3306:3306 \
--publish 8888:8888 \
--publish 3000:3000 \
--publish 4000:4000 \
--publish 1883:1883 \
--publish 8080:8080 \
--publish 5015:5015

rm -rf /home/home_user/home_data/mysql
mkdir /home/home_user/home_data/mysql



podman create \
--name mariadb_container \
--pod home_pod \
--user $uid:$gid \
--log-opt max-size=10mb \
--volume /home/home_user/home_data/mysql:/var/lib/mysql:z \
localhost/mariadb_image:latest

podman create \
--name jupyter_container \
--pod home_pod \
--user $uid:$gid \
--log-opt max-size=10mb \
-v /home/home_user/home_data/notebooks:/notebooks:Z \
localhost/jupyter_image:latest

podman create \
--name reactjs_container \
--pod home_pod \
--log-opt max-size=10mb \
localhost/reactjs_image:latest

## --user $uid:$gid \

podman create \
--name mosquitto_container \
--pod home_pod \
--user $uid:$gid \
--log-opt max-size=10mb \
localhost/mosquitto_image:latest

podman create \
--name dash_container \
--pod home_pod \
--user $uid:$gid \
--log-opt max-size=10mb \
-v /home/home_user/Code/home_podman/dash:/workdir:Z \
localhost/dash_image:latest

podman start mariadb_container
podman start jupyter_container
podman start reactjs_container
podman start mosquitto_container
podman start dash_container
