#!/bin/bash
#
#  Copyright 2019 Gerhard Klostermeier <gerhard@icaria.de>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#


function compile {
    if [ "$1" == "ignore-warnings" ]; then
        # Allow warnings (needed on Android 5.x, 7.x, not needed on 8.x).
        echo "[*] Removing the -Werror flag from Makefiles"
        sed -i 's/-Werror //g' client/Makefile
        sed -i 's/-Werror //g' Makefile.host
        # Make the proxmark3 client.
        echo "[*] Compiling the client"
        make client $2
    else
        # Make the proxmark3 client.
        echo "[*] Compiling the client"
        make client $1
    fi
}


# Main function.
if [ "$1" == "install" ]; then
    # Update Termux packages.
    echo "[*] Udate packages"
    pkg update -y

    # Install proxmark3 client build dependencies.
    echo "[*] Install dependencies"
    pkg install -y git make clang

    # Get the proxmark3 RDV4 repository.
    echo "[*] Get the Proxmark3 RDV4 repository"
    git clone https://github.com/RfidResearchGroup/proxmark3.git
    cd proxmark3
    git restore *
    compile $2 $3
elif [ "$1" == "run" ]; then
    # Run Proxmark3 client (needs root for now).
    echo "[*] Run the Proxmark3 RDV4 client as root on /dev/ttyACM0"
    su -c 'cd proxmark3/client && ./proxmark3 -p /dev/ttyACM0'
elif [ "$1" == "update" ]; then
    echo "[*] Update the Proxmark3 RDV4 repository"
    cd proxmark3
    git restore *
    git pull
    compile $2 $3
else
    echo "Usage: bash termux-pm3.sh <install | run | update> [ignore-warnings] [PLATFORM=PM3OTHER]"
    echo "Running the Proxmark3 client requires root (to access /dev/ttyACM0)."
    echo "Hint: There are plans in the Termux community to support USB-OTG and Bluetooth devices." \
         "Maybe then it will be possible to do this without root."
fi