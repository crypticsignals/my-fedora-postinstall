#!/bin/bash
ORIG_DIR=$(pwd)
cd ~

# PACKAGES
touch .packagelist.txt
echo "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm" > ~/Linux/Installed\ Packages.txt
dnf repoquery --userinstalled --qf "%{name}\n " > ~/Linux/Installed\ Packages.txt
cut -f 4 -d' ' .packagelist.txt >> ~/Linux/my-fedora-postinstall/Installed\ Packages.txt

# FLATPAKS
flatpak list --columns=application > ~/Linux/my-fedora-postinstall/Installed\ Flatpaks.txt

# Remove temporary file and cd back to where you were
rm .packagelist.txt
cd $ORIG_DIR
