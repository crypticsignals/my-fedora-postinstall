#!/bin/bash

# Ideas: https://github.com/polewolf/Fedora-Noble-Setup-fork

# Tailscale
# Instructions taken directly from https://tailscale.com/kb/1511/install-fedora-2
sudo dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
sudo dnf install tailscale
    # Could also do:
    # curl -fsSL https://tailscale.com/install.sh | sh

# 1Password
# Instructions taken directly from https://support.1password.com/install-linux/. 
# Though really I'd just recommend running this from an .rpm file.
 sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
 sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
 sudo dnf install 1password

# VS Code
# Instructions taken directly from https://code.visualstudio.com/docs/setup/linux#_rhel-fedora-and-centos-based-distributions
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf check-update
sudo dnf install code
