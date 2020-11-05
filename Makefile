MARLIN_PATH=Marlin/Marlin
MARLIN_OUT_PATH=$(MARLIN_PATH)/applet
MARLIN_FIRMWARE_HEX=Marlin.hex
MARLIN_FIRMWARE=$(MARLIN_OUT_PATH)/$(MARLIN_FIRMWARE_HEX)

LUFA_PATH=lufa
HID_BOOTLOADER_CLI_PATH=$(LUFA_PATH)/Bootloaders/HID/HostLoaderApp
HID_BOOTLOADER_CLI_NAME=hid_bootloader_cli
HID_BOOTLOADER_CLI=$(HID_BOOTLOADER_CLI_PATH)/$(HID_BOOTLOADER_CLI_NAME)

MAKE:=$(MAKE) -j $(shell nproc)

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir $(mkfile_path))

all: $(MARLIN_FIRMWARE) $(HID_BOOTLOADER_CLI)
	@echo "You can now flash your board with 'make flash'"

$(HID_BOOTLOADER_CLI):
	$(MAKE) -C $(HID_BOOTLOADER_CLI_PATH)

$(MARLIN_FIRMWARE):
	$(MAKE) -C $(MARLIN_PATH) ARDUINO_INSTALL_DIR=$(mkfile_dir)/fake_arduino_install/ HARDWARE_SRC=$(mkfile_dir)/teensy_libs/teensy HARDWARE_MOTHERBOARD=1701 # BOARD_PRINTRBOARD

flash: $(MARLIN_FIRMWARE)
	./$(HID_BOOTLOADER_CLI) -mmcu=at90usb1286 -w -v $(MARLIN_FIRMWARE)

clean:
	$(MAKE) -C $(MARLIN_PATH) clean
	$(MAKE) -C $(HID_BOOTLOADER_CLI_PATH) clean
