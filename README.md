# fusion-deployer
alpine based linux flasher for fusion project

this system is a self contained linux image that will backup the firmware on your piuio to a flash drive, offer you a selection of fusion firmware targets, and allow you to swap between them easily.

keep this flash drive in your coin bucket to swap between modes such as lxio, gamepad, piuio, and restore your backed up firmware.

# requirements

* 256MB flash drive are larger
* a stock piuio
* keyboard
* computer inside your arcade cabinet
* legacy boot enabled on your motherboard

# disclaimer

this action will apply new firmware to your piuio inside your expensive arcade equipment.

firmware is backed up to the flash drive before flashing, but there is no warranty on this software. 

**all risk for flashing the device is your own and no one else can be responsible for the actions of this software.**

the author cannot provide detailed technical support on this project nor can the safety of your equipment be guaranteed.

this alternative firmware does not guarantee the ability to use in online events, user discretion is advised.

please take the necessary precautions and do not work on equipment you are not the direct owner of.

github issues related to troubleshooting the process will be closed and ignored.

# how to setup the flash drive

* click the release tab
* download the latest `fusion-flasher*.img.gz`
* use your favorite disc writing tool like dd/gzip, balena etcher, etc to flash the `.img.gz` to the flash drive
* once the copy is complete, safely eject the flash drive

# how to flash the piuio

* turn off all arcade hardware
* disconnect all flash drives, hard drives, and security dongles from your computer/mk*/etc
* plug in the flash drive you just created
* plug in your keyboard
* power on your arcade hardware
* allow the system to boot to the fusion menu
    * if the usb drive does not boot, ensure your motherboard is set to allow legacy booting. 
* select your target mode (lxio, gamepad, etc)
* your firmware will be backed up to the flash drive and the system will power down
* power off the arcade hardware from the wall
* ***YOU MUST FULLY POWER OFF THE CABINET FOR THE FIRMWARE TO APPLY***
* reconnect your game drive
* power on your arcade hardware
* enjoy!

# optional, but *highly* recommended

a backup of your piuio firmware is saved to the flash drive. 

please save the `stock_piuio.ihex` file in the `fusion` folder for save keeping on another computer, nas, cloud storage, etc.

this is your original firmware and can be reapplied at any time using the flasher.

# building the flasher

from root (to create the loopback object), run the build script:

```
# ./build.sh
```

a new `fusion-flasher*.img.gz` is created to be flashed to a flash drive and applied.

# testing

testing qemu environment for the flasher is in the test script.

```
# ./test.sh
```

# credits

* [alpine](https://www.alpinelinux.org/) is pretty cool as a project, check them out
* forked from [alpinelinux/alpine-make-vm-image](https://github.com/alpinelinux/alpine-make-vm-image), thank you so much
* main firmware project is here [dinsfire64/fusion](https://github.com/dinsfire64/fusion)