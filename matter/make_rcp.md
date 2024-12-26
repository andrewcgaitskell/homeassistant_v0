

git clone --recursive https://github.com/openthread/ot-nrf528xx.git
cd ot-nrf528xx/
./script/bootstrap
script/build nrf52840 USB_trans -DOT_BOOTLOADER=USB -DOT_THREAD_VERSION=1.2

cd build/bin
arm-none-eabi-objcopy -O ihex ot-rcp ot-rcp.hex

uploaded to drive

needed to use nrf connect desktop tool to flash to dongle
