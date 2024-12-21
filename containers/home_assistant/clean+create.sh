podman stop home_assistant_container_1
podman rm home_assistant_container_1

podman build -t home_assistant_image_1 .

podman run -d \
    --name home_assistant_container_1 \
    --network=host \
    -e TZ=Europe/London \
    --userns=keep-id \
    -v /home/pi5ha/homeassistant_v0/containers/home_assistant/config:/config:Z \
    home_assistant_image_1
