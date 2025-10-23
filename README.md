# fusion-deployer
Alpine-based Linux flasher for fusion project

This system is a self-contained Linux image that will backup the firmware on your PIUIO to a flash drive, offer you a selection of fusion firmware targets, and allow you to swap between them easily.

Keep this flash drive in your coin bucket to swap between modes such as LXIO, gamepad, PIUIO, and restore your backed up firmware.

# Requirements

* 256 MB flash drive or larger
* Stock PIUIO
* Keyboard
* Computer inside your arcade cabinet
* Legacy boot enabled on your motherboard

# Disclaimer

This action will apply new firmware to your PIUIO inside your expensive arcade equipment.

The original firmware is backed up to the flash drive before flashing, but there is no warranty on this software. 

**All risk for flashing the device is your own and no one else can be responsible for the actions of this software.**

The author **cannot** provide detailed technical support on this project nor can the safety of your equipment be guaranteed.

This alternative firmware does not guarantee the ability to use in online events, user discretion is advised.

Please take the necessary precautions and do not work on equipment you are not the direct owner of.

GitHub issues related to troubleshooting the process will be closed and ignored.

# How to setup the flash drive

* Click the release tab
* Download the latest `fusion-flasher*.img.gz`
* Use your favorite disc writing tool like dd/gzip, balenaEtcher, etc. to flash the `.img.gz` to the flash drive
* Once the copy is complete, safely eject the flash drive

# How to pick an option to flash

fusion has multiple different firmware targets that changes the way it shows up to games and computers.

* LXIO: This will make the device show up as an 0x1020 "LXIO" or PumpHID/Nuvoton Pump device. You will get full 1khz compatibility with games and software that is written for it.
* Gamepad: This turns the device into a generic HID gamepad with reactive lights. Use for general purpose PC use for generic games. This also offers the ability to control the lights with software on the PC.
* Keyboard: This option is useful for older games with compatibility problems with the gamepad mode. Maps the device to QESZC and numpad 79513.
* PIUIO: This option will let the device show up as a PIUIO for all legacy games and software that support it. The advantage is it will poll at a higher rate, allowing up to 4x resolution in polling for games that otherwise don't support an LXIO.
* Stock PIUIO: This will restore the backup of the firmware that is taken on first flash. This will return your device to stock settings just as when you started.


# How to flash the PIUIO

* Turn off all arcade hardware
* Disconnect all storage devices (flash drives, hard drives, SSD, etc.) and security dongle from your computer/MK
* Plug in the flash drive you just created
* Plug in your keyboard
* Power on your arcade hardware
* Allow the system to boot to the fusion menu
    * If the flash drive does not boot, ensure your motherboard is set to allow legacy booting. 
* Select your target mode (LXIO, gamepad, etc.)
* Your firmware will be backed up to the flash drive and the system will power down
* Power off your arcade hardware
* ***YOU MUST FULLY POWER OFF THE CABINET FOR THE FIRMWARE TO APPLY***
* Reconnect your game drive and security dongle
* Power on your arcade hardware
* Enjoy!

# Optional, but *highly* recommended

A backup of your PIUIO firmware is saved to the flash drive. 

Please save the `stock_piuio.ihex` file in the `fusion` folder for save keeping on another computer, NAS, cloud storage, etc.

This is your original firmware and can be reapplied at any time using the flasher.

# Building the flasher

From root (to create the loopback object), run the build script:

```
# ./build.sh
```

A new `fusion-flasher*.img.gz` is created to be flashed to a flash drive and applied.

# Testing

Testing QEMU environment for the flasher is in the test script.

```
# ./test.sh
```

# credits

* [Alpine](https://www.alpinelinux.org/) is pretty cool as a project, check them out
* Forked from [alpinelinux/alpine-make-vm-image](https://github.com/alpinelinux/alpine-make-vm-image), thank you so much
* Main firmware project is here [dinsfire64/fusion](https://github.com/dinsfire64/fusion)
