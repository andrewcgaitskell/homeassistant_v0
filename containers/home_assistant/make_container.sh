STATUS="home_dev"
podman pod stop ${STATUS}_pod
podman pod rm ${STATUS}_pod

uid=${ENV_UID} ##1001
gid=${ENV_GID} ##1002

subuidSize=$(( $(podman info --format "{{ range \
   .Host.IDMappings.UIDMap }}+{{.Size }}{{end }}" ) - 1 ))
subgidSize=$(( $(podman info --format "{{ range \
   .Host.IDMappings.GIDMap }}+{{.Size }}{{end }}" ) - 1 ))

podman run -d \
    --name home_assistant_container_1 \
    --pod ${STATUS}_pod \
    --network=host \
    -e TZ=Europe/London \
    --user $uid:$gid \
    -v /home/pi5ha/homeassistant_v0/containers/home_assistant/config:/config:Z \
    home_assistant_image_2
