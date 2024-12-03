cd /home/home_user/Code/home_podman/reactjs

podman stop reactjs_container
podman rm reactjs_container

podman rmi reactjs_image_root
podman rmi reactjs_image_user
podman rmi reactjs_image

podman build \
-f Dockerfile_root -t reactjs_image

#podman build \
#--build-arg=BUILD_ENV_UID=${ENV_UID} \
#--build-arg=BUILD_ENV_USERNAME=${ENV_USERNAME} \
#--build-arg=BUILD_ENV_GID=${ENV_GID} \
#--build-arg=BUILD_ENV_GROUPNAME=${ENV_GROUPNAME} \
#-f Dockerfile_user -t reactjs_image_user

