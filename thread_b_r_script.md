Thanks to : https://github.com/espressif/connectedhomeip/blob/903e149bd636a5cd1a8821864cb073b4f7a9d3d8/docs/guides/openthread_rcp_nrf_dongle.md?plain=1#L21

And : https://openthread.io/codelabs/openthread-hardware#2

## Building and programming the RCP firmware onto an nRF52840 Dongle

Run the following commands to build and program the RCP firmware onto an
nRF52840 Dongle:

1.  Clone the OpenThread nRF528xx platform repository into the current
    directory:

        $ git clone --recursive https://github.com/openthread/ot-nrf528xx.git

2.  Enter the _ot-nrf528xx_ directory:

        $ cd ot-nrf528xx

3.  Install OpenThread dependencies:

        $ ./script/bootstrap

4.  Build OpenThread for the nRF52840 Dongle:

       >>>>>>>>>> script/build nrf52840 USB_trans -DOT_BOOTLOADER=USB -DOT_THREAD_VERSION=1.2 <<<<<<<<<<<<< DID NOT WORK
       script/build nrf52840 USB_trans - THIS DID
       >>>>>>>>>
       script/build nrf52840 USB_trans -DOT_BOOTLOADER=USB

    This creates an RCP image at `build/bin/ot-rcp`.

Go back to ot-nrf528xx folder

6.  Convert the RCP image to the `.hex` format:

        $ arm-none-eabi-objcopy -O ihex build/bin/ot-rcp build/bin/ot-rcp.hex

7.    enable Pipenv

8.  Install nrfutil

        python -m pip install -U nrfutil
    

10.  Generate the RCP firmware package:

        $ nrfutil pkg generate --hw-version 52 --sd-req=0x00 \
            --application build/bin/ot-rcp.hex \
            --application-version 1 build/bin/ot-rcp.zip

11.  Connect the nRF52840 Dongle to the USB port
12.  Discover Device
        ls /dev/ttyACM*
        /dev/ttyACM0

13.  Press the **Reset** button on the dongle to put it into the DFU mode. Red
    LED on the dongle starts blinking.

14. To install the RCP firmware package onto the dongle, run the following
    command, with _/dev/ttyACM0_ replaced with the device node name of your
    nRF52840 Dongle:

        $ nrfutil dfu usb-serial -pkg build/bin/ot-rcp.zip -p /dev/ttyACM0

# Adding TBR to Docker Container

docker run --sysctl "net.ipv6.conf.all.disable_ipv6=0 net.ipv4.conf.all.forwarding=1 net.ipv6.conf.all.forwarding=1" -p 8080:80 --dns=127.0.0.1 -it --volume /dev/ttyACM0:/dev/ttyACM0 --privileged openthread/otbr --radio-url spinel+hdlc+uart:///dev/ttyACM0

        convert to docker compose
        
        version: "3.8"
        services:
          # python-matter-server
          matter-server:
            image: ghcr.io/home-assistant-libs/python-matter-server:stable
            container_name: matter-server
            restart: unless-stopped
            # Required for mDNS to work correctly
            network_mode: host
            security_opt:
              # Needed for Bluetooth via dbus
              - apparmor:unconfined
            volumes:
              # Create an .env file that sets the USERDIR environment variable.
              - ${USERDIR:-$HOME}/docker/matter-server/data:/data/
              - /run/dbus:/run/dbus:ro
        
        version: "2.1"
        
        services:
           openthread_border_router:
             image: openthread/otbr
             volumes:
               - /dev/ttyACM0:/dev/ttyACM0
             sysctls:
               net.ipv6.conf.all.disable_ipv6: 0
               net.ipv4.conf.all.forwarding: 1
               net.ipv6.conf.all.forwarding: 1
             ports:
               - 8080:80
             dns:
               - 127.0.0.1
             privileged: true
             command: ["--radio-url", "spinel+hdlc+uart:///dev/ttyACM0"]
             # network_mode: host
             networks:
               ipv6net:
                  ipv6_address: 2001:3984:3989::20
        
           coap_logger:
             build: ./coap_logger
             command: ["python", "coap_echo.py"]
             # network_mode: host
             networks:
              - ipv6net
             cap_add:
               - NET_ADMIN
        
         networks:
           ipv6net:
             driver: bridge
             enable_ipv6: true
             ipam:
               driver: default
               config:
               - subnet: 2001:3984:3989::/64
                 gateway: 2001:3984:3989::1


# Workings

--sysctl "net.ipv6.conf.all.disable_ipv6=0 net.ipv4.conf.all.forwarding=1 net.ipv6.conf.all.forwarding=1" -p 8080:80 --dns=127.0.0.1 -it --volume /dev/ttyACM0:/dev/ttyACM0 --privileged openthread/otbr --radio-url spinel+hdlc+uart:///dev/ttyACM0

    services:
       openthread_border_router:
         image: openthread/otbr
         volumes:
           - /dev/ttyACM0:/dev/ttyACM0
         sysctls:
           net.ipv6.conf.all.disable_ipv6: 0
           net.ipv4.conf.all.forwarding: 1
           net.ipv6.conf.all.forwarding: 1
         ports:
           - 8080:80
         dns:
           - 127.0.0.1
         privileged: true
         command: ["--radio-url", "spinel+hdlc+uart:///dev/ttyACM0"]
         # network_mode: host
