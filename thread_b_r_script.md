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
