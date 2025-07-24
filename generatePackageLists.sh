#!/bin/bash
HOST_NAME=$(hostname)
mkdir -p data/
DATA_DIR=$(readlink -f data/)

# PACKAGES
dnf repoquery --userinstalled --qf "%{name}\n" > $DATA_DIR/$HOST_NAME-installedPackages.txt

# FLATPAKS
flatpak list --columns=application,origin > "$DATA_DIR/$HOST_NAME-installedFlatpaks.txt"

printf "\n"
echo "Package list export completed. Your exported files are in $DATA_DIR."
echo "**PLEASE EXPORT THESE SOMEWHERE THAT WILL NOT BE LOST UPON CHANGING SYSTEMS!**"
printf "\n"
echo "When you're ready to reinstall packages, simply clone this repository on the target system and then place your exported files in the data directory there, and run it."
printf "\n"