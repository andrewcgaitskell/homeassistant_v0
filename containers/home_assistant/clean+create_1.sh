podman stop home_assistant_container_1
podman rm home_assistant_container_1

podman build -f Dockerfile_1 -t home_assistant_image_1 .
