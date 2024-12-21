podman stop home_assistant_container_1
podman rm home_assistant_container_1

podman build \
--build-arg=BUILD_ENV_UID=${ENV_UID} \
--build-arg=BUILD_ENV_USERNAME=${ENV_USERNAME} \
--build-arg=BUILD_ENV_GID=${ENV_GID} \
--build-arg=BUILD_ENV_GROUPNAME=${ENV_GROUPNAME} \
-f Dockerfile_1 -t home_assistant_image_1 .
