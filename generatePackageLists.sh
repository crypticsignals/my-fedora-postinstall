#!/bin/bash
HOST_NAME=$(hostname)
DATA_DIR=$(readlink -f data/)

# PACKAGES
dnf repoquery --userinstalled --qf "%{name}\n" > $DATA_DIR/$HOST_NAME-installedPackages.txt
echo "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" >> $DATA_DIR/$HOST_NAME-installedPackages.txt
echo "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm" >> $DATA_DIR/$HOST_NAME-installedPackages.txt


# FLATPAKS
flatpak list --columns=application,origin > "$DATA_DIR/$HOST_NAME-installedFlatpaks.txt"