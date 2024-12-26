Yes, you can prepare the NRF52840 dongle via Docker by running a container that provides the necessary tools and environment to flash the NCP firmware.


This eliminates the need to install Nordic's tools directly on your Raspberry Pi.

Here’s how to do it:
Step 1: Prepare the NRF52840 Dongle Using Docker
1.1 Use a Docker Image with nRF Tools

    Pull an nRF Tools Image Use a Docker image pre-configured with Nordic's Command Line Tools. For example, this image.

    Pull the image:

    docker pull ewpa/nrfutil

1.2 Connect Your NRF52840 Dongle

    Plug the NRF52840 dongle into your Raspberry Pi.
    Identify the serial port:

    ls /dev/ttyACM*

    Example output: /dev/ttyACM0.

1.3 Run the nRF Tools Container

Run a container with the nrfutil tool and bind the serial port of the dongle:

docker run -it --rm \
    --device=/dev/ttyACM0 \
    -v $(pwd):/data \
    ewpa/nrfutil

This mounts the current directory to /data in the container and provides access to the dongle.
1.4 Download NCP Firmware

Inside the container, download the NCP firmware from the OpenThread GitHub Releases:

wget https://github.com/openthread/openthread/releases/download/<release_version>/ncp_firmware.zip

Replace <release_version> with the desired version (e.g., v20210213).
1.5 Flash the Firmware

Use the nrfutil tool inside the container to flash the firmware:

nrfutil dfu usb-serial -pkg /data/ncp_firmware.zip -p /dev/ttyACM0

1.6 Exit the Container

Once the flashing is complete, exit the container:

exit

Step 2: Verify the Dongle

    Confirm the dongle is accessible on the Raspberry Pi:

    ls /dev/ttyACM*

    If the device is listed (e.g., /dev/ttyACM0), the dongle is ready for use with the OTBR.

This approach lets you flash the dongle entirely within Docker, avoiding any need for direct installations on your Raspberry Pi. Let me know if you need further help!
