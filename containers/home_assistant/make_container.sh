uid=${ENV_UID} ##1001
gid=${ENV_GID} ##1002

subuidSize=$(( $(podman info --format "{{ range \
   .Host.IDMappings.UIDMap }}+{{.Size }}{{end }}" ) - 1 ))
subgidSize=$(( $(podman info --format "{{ range \
   .Host.IDMappings.GIDMap }}+{{.Size }}{{end }}" ) - 1 ))

podman stop home_assistant_container_1
podman rm home_assistant_container_1

podman run -d \
    --name home_assistant_container_1 \
    -p 8123:8123 \
    -e TZ=Europe/London \
    --user $uid:$gid \
    --network=host \
    home_assistant_image_2

