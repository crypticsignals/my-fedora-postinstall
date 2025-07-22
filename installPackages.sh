#!/bin/bash

HOST_NAME=$(hostname)
DATA_DIR=$(readlink -f data/)

# Disclaimer
echo "Please read the descriptions this script gives you. It will tell you everything you'll need to know."
echo "Running this script will install all differring packages and flatpaks on your system based on what's in your exported list."
read -p "Continue? (y/n): " answer
if [[ "$answer" != "y" ]]; then
	echo "Exiting."
	exit 0
fi

# RPM Packages
printf "\n"
read -p "Would you like to run (W)ith confirmation or with (N)o confirmation? " answer2
if [[ $answer2 == "w" || $answer2 == "W" ]]; then
	sudo dnf install $(<"$DATA_DIR/$HOST_NAME-installedPackages.txt")
	echo "Success."
	sleep 2
	clear
elif [[ $answer2 == "n" || $answer2 == "N" ]]; then
	sudo dnf install -y $(<"$DATA_DIR/$HOST_NAME-installedPackages.txt")
	echo "Success."
	sleep 2
	clear
else
	echo "Unrecognized output. Skipping."
	sleep 2
	clear
fi

# Flatpaks
echo "IMPORTANT: If some of your previously installed flatpaks come from flathub or any other remotes, you will need to take the steps to enable that remote on your distro to continue."
	# I will not be adding code to do this, even with a choice, for a few reasons:
	# - Primarily, preservation of user security. I don't want to just open up a door to a random remote for no reason.
	# - Differring steps of adding remotes per distro outside of flatpak remote-add <remote>
	# - There's plenty of remotes out there. I pretty much only have fedora and flathub personally, but I don't want to accidentally break someone's runtime by potentially adding in disruptive code.

printf "\nThis step will be a bit different. This will print out a list of your flatpaks.\nIf everything looks good, answer Y on the prompt that comes after to install everything.\nIf not, enter ctrl+c or anything other than y to stop this step.\nFrom this point, you'll need to manually edit your flatpak list if something looks incorrect.\n"

read -n 1 -s -r -p "Press any key to continue..."
printf "\n\n"
cat "$DATA_DIR/$HOST_NAME-installedFlatpaks.txt"
printf "\n"

read -p "Does everything look okay? (y/n): " answer3
if [[ $answer3 == "y" || $answer3 == "Y" ]]; then
	while read -r app remote; do
    sudo flatpak install -y "$remote" "$app"
	done < "$DATA_DIR/$HOST_NAME-installedFlatpaks.txt"
else
	echo "Skipping."
fi

printf "\n"