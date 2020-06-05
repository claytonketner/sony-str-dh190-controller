# You can find the board and port using:
#	arduino-cli board list

BOARD?=arduino:avr:uno
PORT?=/dev/cu.usbmodem14401
PROJECT=sony-str-dh190-controller
INO_PATH=$(PROJECT)/$(PROJECT).ino
ELF=$(PROJECT)/$(PROJECT)*.elf


.PHONY: default
default: upload

$(ELF): $(INO_PATH)
	arduino-cli compile sony-str-dh190-controller -b $(BOARD)

.PHONY: build
build: $(ELF)

.PHONY: upload
upload: build
	arduino-cli upload sony-str-dh190-controller -p $(PORT) -b $(BOARD)
