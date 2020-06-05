# You can find the board and port using:
#	arduino-cli board list

BOARD?=arduino:avr:uno
PORT?=/dev/cu.usbmodem14401
PROJECT=sony-str-dh190-controller
PROJECT_PATH=$(PWD)/$(PROJECT)
INO_PATH=$(PROJECT_PATH)/$(PROJECT).ino
BUILD_PATH=$(PROJECT_PATH)/build
BUILD_ARTIFACTS=$(BUILD_PATH)/$(PROJECT).ino.hex


.PHONY: default
default: build upload

$(BUILD_ARTIFACTS): $(INO_PATH)
	arduino-cli compile $(PROJECT) -b $(BOARD) --build-path $(BUILD_PATH)
	# Why does it make these duplicate useless files that I don't want???
	rm $(PROJECT_PATH)/$(PROJECT)*.hex
	rm $(PROJECT_PATH)/$(PROJECT)*.elf

.PHONY: build
build: $(BUILD_ARTIFACTS)

.PHONY: upload
upload: build
	arduino-cli upload $(PROJECT) -p $(PORT) -b $(BOARD) -i $(BUILD_PATH)/$(PROJECT).ino
