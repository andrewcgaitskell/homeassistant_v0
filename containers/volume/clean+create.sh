#!/bin/bash

podman rmi volume_image
podman stop volume_container
podman rm volume_container

mkdir -p  ~/volume_test
chmod 700  ~/volume_test

podman build -f Dockerfile -t volume_image .

podman run --rm \
  --name volume_container \
  --volume ~/volume_test:/data \
  volume_image
  
