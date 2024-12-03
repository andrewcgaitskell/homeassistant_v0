
## Install Docker on to Pi 4B with 64Bit OS

Thank you to : https://docs.docker.com/engine/install/debian/#install-using-the-convenience-script

     curl -fsSL https://get.docker.com -o get-docker.sh
    
     sudo sh ./get-docker.sh

Thank you to : https://www.home-assistant.io/installation/raspberrypi

# Text
## Install Home Assistant Container

These below instructions are for an installation of Home Assistant Container running in your own container environment, which you manage yourself. Any OCI compatible runtime can be used, however this guide will focus on installing it with Docker.
Prerequisites

This guide assumes that you already have an operating system setup and a container runtime installed (like Docker).

If you are using Docker then you need to be on at least version 19.03.9, ideally an even higher version, and libseccomp 2.4.2 or newer.
Platform installation

Installation with Docker is straightforward. Adjust the following command so that:

    /PATH_TO_YOUR_CONFIG points at the folder where you want to store your configuration and run it. Make sure that you keep the :/config part.

    MY_TIME_ZONE is a tz database name, like TZ=America/Los_Angeles.

    D-Bus is optional but required if you plan to use the Bluetooth integration.
    Install
    Update

    docker run -d \
      --name homeassistant \
      --privileged \
      --restart=unless-stopped \
      -e TZ=MY_TIME_ZONE \
      -v /PATH_TO_YOUR_CONFIG:/config \
      -v /run/dbus:/run/dbus:ro \
      --network=host \
      ghcr.io/home-assistant/home-assistant:stable

    Bash

Once the Home Assistant Container is running Home Assistant should be accessible using http://<host>:8123 (replace with the hostname or IP of the system). You can continue with onboarding.

## Onboarding

Restart Home Assistant

If you change the configuration, you have to restart the server. To do that you have 3 options.

    In your Home Assistant UI, go to the Settings > System and click the Restart button.
    You can go to the Developer Tools > Services, select the service homeassistant.restart and select Call Service.
    Restart it from a terminal.

## Docker CLI

Docker Compose

docker restart homeassistant

Bash

Docker compose

docker compose should already be installed on your system. If not, you can manually install it.

As the Docker command becomes more complex, switching to docker compose can be preferable and support automatically restarting on failure or system restart. Create a compose.yml file:

version: '3'
services:
  homeassistant:
    container_name: homeassistant
    image: "ghcr.io/home-assistant/home-assistant:stable"
    volumes:
      - /PATH_TO_YOUR_CONFIG:/config
      - /etc/localtime:/etc/localtime:ro
      - /run/dbus:/run/dbus:ro
    restart: unless-stopped
    privileged: true
    network_mode: host

YAML

Start it by running:

docker compose up -d

Bash

Once the Home Assistant Container is running, Home Assistant should be accessible using http://<host>:8123 (replace with the hostname or IP of the system). You can continue with onboarding.

Onboarding
Exposing devices

In order to use Zigbee or other integrations that require access to devices, you need to map the appropriate device into the container. Ensure the user that is running the container has the correct privileges to access the /dev/tty* file, then add the device mapping to your container instructions:

## Docker CLI

Docker Compose

docker run ... --device /dev/ttyUSB0:/dev/ttyUSB0 ...

Bash
Optimizations

The Home Assistant Container is using an alternative memory allocation library jemalloc for better memory management and Python runtime speedup.

As jemalloc can cause issues on certain hardware, it can be disabled by passing the environment variable DISABLE_JEMALLOC with any value, for example:
Docker CLI
Docker Compose

docker run ... -e "DISABLE_JEMALLOC=true" ...

Bash

The error message <jemalloc>: Unsupported system page size is one known indicator.
