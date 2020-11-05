# Printrboard updater

This allows to easily update the Solidoodle Motherboard rev-E based on the
printrboard.

In theory this could be used to update any at90usb1286 based boards running
lufa HID bootloader, but I only own the Solidoodle Motherboard rev-E so I only
tested this on this board. It could also easily be modified to be compatible
with the CDC and DFU bootloaders.

# Instructions

## Using Docker (recommended)

* First build the docker image
  ```
  $ docker build . -t printrboard-updater
  ```

* Tweak the configuration to your liking
  You can tweak `Configuration.h` and `Configuration_adv.h` files in the
  `Marlin/Marlin` folder

* Build the firmware along with the flashing tool
  ```
  $ docker run -it -v $(pwd):/printrboard-updater -u $UID printrboard-updater
  ```

* Prepare your board for flashing

  Put a jumper accross the two boot pins near the microcontroller as follows:
  Plug your board with the USB cable
  Push on the reset button on the board

* Finally, you can flash your board with the following command:
  ```
  $ docker run -it --privileged -v $(pwd):/printrboard-updater printrboard-updater make flash
  ```

  Note: running in privileged mode is only necessary if you want to
  autodiscover the device, you can also run:
  ```
  $ lsusb
  ...
  Bus 001 Device 025: ID 03eb:2067 Atmel Corp.
  ...
  $ docker run -it --device /dev/bus/usb/the-bus-number/the-device-number -v $(pwd):/printrboard-updater printrboard-updater make flash
  ```

## Without docker

* Install the dependencies
  You need:
  * avr-gcc version <= 8.3.0 (Teensy lib does not compile with newer versions)
  * avr-libc
  * gcc
  * libc Development Libraries and Header Files
  * libusb Development Libraries and Header Files
  * make

* Tweak the configuration to your liking
  You can tweak `Configuration.h` and `Configuration_adv.h` files in the
  `Marlin/Marlin` folder.

* Build `Marlin` and `hid_bootloader_cli`
  ```
  $ make
  ```

* Flash the firmware to your board

  Put a jumper accross the two boot pins near the microcontroller as follows:

  Plug your board with the USB cable
  Push on the reset button

  Run make flash
  ```
  $ sudo make flash
  ```
