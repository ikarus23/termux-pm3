Termux Proxmark3 Client
=======================

This script helps you to compile and run the [Proxmark3](http://www.proxmark.org/) client on Android. No special
software is needed, just the [Termux](https://termux.com/) app.

The script will install the [RDV4 version](https://github.com/RfidResearchGroup/proxmark3) of the client.



Requirements
------------

* Android device with root access and USB-OTG support
* USB-OTG adapter
* [Termux app](https://termux.com/)
* Proxmark3 with the latest (git master branch) [RDV4 firmware](https://github.com/RfidResearchGroup/proxmark3)
flashed on it

Root access is needed for now. There are plans in the Termux community to support USB-OTG and Bluetooth devices.
It should be possible to drop the root requirement once Termux has USB-OTG and/or Bluetooth support.



Installation
------------

Run the following commands in Termux:
```
pkg install git
git clone https://github.com/ikarus23/termux-pm3.git
cd termux-pm3
bash termux-pm3.sh install
```
There are some issues with Android 5.x and 7.x (and maybe other) which stops the compiling process.
Try the following command, it might help:
```
bash termux-pm3-sh install ignore-warnings
```
If you don't have a Proxmark RDV4 you need to add the `PLATFORM=PM3OTHER` flag. You might also want to check out
`PLATFORM=help`.
```
bash termux-pm3-sh install [ignore-warnings] PLATFORM=PM3OTHER
```
Another hint: Do not run this script from within `/sdcard`. This could lead to troubles regarding the
permission to execute a binary. Just run it from within the Termux root (default) directory.



Usage
-----

Connect the Proxmark3 via USB-OTG to your Android device and run the following command from within the
`termux-pm3` folder in Termux:
```
bash termux-pm3.sh run
```
To update the Proxmark3 client just run:
```
bash termux-pm3.sh update [ignore-warnings] [PLATFORM=PM3OTHER]
```
