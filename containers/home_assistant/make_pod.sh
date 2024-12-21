#!/bin/bash

# Pod name and user IDs
STATUS="home_dev"
ENV_UID=1000
ENV_GID=1000

# Stop and remove existing pod
podman pod stop ${STATUS}_pod 2>/dev/null
podman pod rm ${STATUS}_pod 2>/dev/null

# Calculate subuid/subgid sizes
subuidSize=$(( $(podman info --format "{{ range .Host.IDMappings.UIDMap }}+{{.Size }}{{end }}" ) - 1 ))
subgidSize=$(( $(podman info --format "{{ range .Host.IDMappings.GIDMap }}+{{.Size }}{{end }}" ) - 1 ))

# Create the pod
podman pod create \
  --name ${STATUS}_pod \
  --infra-name infra_dev \
  --network bridge \
  --uidmap 0:1:$ENV_UID \
  --uidmap $ENV_UID:0:1 \
  --uidmap $(($ENV_UID+1)):$(($ENV_UID+1)):$(($subuidSize-$ENV_UID)) \
  --gidmap 0:1:$ENV_GID \
  --gidmap $ENV_GID:0:1 \
  --gidmap $(($ENV_GID+1)):$(($ENV_GID+1)):$(($subgidSize-$ENV_GID)) \
  --publish 8123:8123

# Check if the pod was created successfully
if podman pod ps | grep -q "${STATUS}_pod"; then
  echo "Pod '${STATUS}_pod' created successfully!"
else
  echo "Failed to create pod '${STATUS}_pod'. Check logs for details."
  exit 1
fi
