podman rm home_assistant_image_2

podman build \
--format=docker \
--build-arg=BUILD_ENV_UID=${ENV_UID} \
--build-arg=BUILD_ENV_USERNAME=${ENV_USERNAME} \
--build-arg=BUILD_ENV_GID=${ENV_GID} \
--build-arg=BUILD_ENV_GROUPNAME=${ENV_GROUPNAME} \
-f Dockerfile_2 -t home_assistant_image_2 .
