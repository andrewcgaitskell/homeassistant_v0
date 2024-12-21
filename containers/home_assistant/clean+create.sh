podman stop home_assistant_container_1
podman rm home_assistant_container_1

podman build -t home_assistant_image_1 .

podman run -d \
    --name home_assistant_container_1 \
    --network=host \
    -e TZ=Your/Timezone \
    -v /path/to/config:/config \
    home_assistant_image_1