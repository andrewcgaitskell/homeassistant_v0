uid=${ENV_UID} ##1001
gid=${ENV_GID} ##1002

subuidSize=$(( $(podman info --format "{{ range \
   .Host.IDMappings.UIDMap }}+{{.Size }}{{end }}" ) - 1 ))
subgidSize=$(( $(podman info --format "{{ range \
   .Host.IDMappings.GIDMap }}+{{.Size }}{{end }}" ) - 1 ))

mkdir -p /home/pi5ha/homeassistant/test

rm /home/pi5ha/homeassistant/config/configuration.yaml
cp /home/pi5ha/homeassistant_v0/containers/home_assistant/config/configuration.yaml /home/pi5ha/homeassistant/config/configuration.yaml

chmod -R g+rwx /home/pi5ha/homeassistant/config
chmod g+s /home/pi5ha/homeassistant/config

podman stop home_assistant_container_1
podman rm home_assistant_container_1

podman run -d \
    --name home_assistant_container_1 \
    -p 8123:8123 \
    -e TZ=Europe/London \
    -v /home/pi5ha/homeassistant/test:/test \
    -v /home/pi5ha/homeassistant/config:/config \
    --userns=keep-id \
    home_assistant_image_3

## -v /home/pi5ha/homeassistant/config:/config \
## -v homeassistant_config_volume:/config \
