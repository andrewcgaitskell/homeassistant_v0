## Jupyter

cd /home_podman/jupyter_2

podman stop jupyter_container
podman rm jupyter_container

podman rmi jupyter_image

podman build \
--build-arg=BUILD_ENV_UID=${ENV_UID} \
--build-arg=BUILD_ENV_USERNAME=${ENV_USERNAME} \
--build-arg=BUILD_ENV_GID=${ENV_GID} \
--build-arg=BUILD_ENV_GROUPNAME=${ENV_GROUPNAME} \
-f Dockerfile -t jupyter_image

