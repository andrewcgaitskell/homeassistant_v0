Thanks to : https://github.com/espressif/connectedhomeip/blob/903e149bd636a5cd1a8821864cb073b4f7a9d3d8/docs/guides/openthread_rcp_nrf_dongle.md?plain=1#L21

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

         $ script/build nrf52840 USB_trans -DOT_BOOTLOADER=USB -DOT_THREAD_VERSION=1.2

    This creates an RCP image at `build/bin/ot-rcp`.

5.  Convert the RCP image to the `.hex` format:

        $ arm-none-eabi-objcopy -O ihex build/bin/ot-rcp build/bin/ot-rcp.hex

6.  Install
    [nRF Util](https://www.nordicsemi.com/Software-and-tools/Development-Tools/nRF-Util):

        $ python3 -m pip install -U nrfutil

7.  Generate the RCP firmware package:

        $ nrfutil pkg generate --hw-version 52 --sd-req=0x00 \
            --application build/bin/ot-rcp.hex \
            --application-version 1 build/bin/ot-rcp.zip

8.  Connect the nRF52840 Dongle to the USB port.

9.  Press the **Reset** button on the dongle to put it into the DFU mode. Red
    LED on the dongle starts blinking.

10. To install the RCP firmware package onto the dongle, run the following
    command, with _/dev/ttyACM0_ replaced with the device node name of your
    nRF52840 Dongle:

        $ nrfutil dfu usb-serial -pkg build/bin/ot-rcp.zip -p /dev/ttyACM0
