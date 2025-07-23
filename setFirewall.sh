#!/bin/bash

printf "Please read the contents of this script beforehand. This will initially start off by clearing your \nentire firewall configuration. After this you'll be able to set your own ports through an automated process. \nIf you haven't done any form of setup on your firewall yet, and want to have more secure configs, this will \nonly help you.\n"

read -n 1 -s -r -p "Press any key to continue, or ctrl+c to exit."
clear
printf "This is your current firewall configuration (which needs sudo permissions to show):\n\n"
sudo firewall-cmd --list-all

printf "\nThere's a few options you might want.\n 1 - Clear default configs, set new ports\n 2 - Clear default configs, do not set new ports\n 3 - Do not touch port configurations\n\n"
read -p "Enter your choice: " portconfigchoice
if [[ $portconfigchoice == 1 ]]; then
    sudo firewall-cmd --remove-port=1025-65535/tcp --permanent
    read -p "Enter ports you'd like to add, separated by a space: " portlist
    for i in $portlist; do
        read -p "For port $i: (T)CP, (U)DP, or (B)oth? " tcporudp
        if [[ $tcporudp == "t" || $tcporudp == "T" ]]; then
            sudo firewall-cmd --add-port $i/tcp --permanent
        elif [[ $tcporudp == "u" || $tcporudp == "U" ]]; then
            sudo firewall-cmd --add-port $i/udp --permanent
        elif [[ $tcporudp == "b" || $tcporudp == "B" ]]; then
            sudo firewall-cmd --add-port $i/tcp --permanent
            sudo firewall-cmd --add-port $i/udp --permanent
        fi;
    done
elif [[ $portconfigchoice == 2 ]]; then
    sudo firewall-cmd --remove-port=1025-65535/tcp --permanent
fi

echo "Changes set."
sleep 3
clear

read -p "Configure SSH? (y/n): " cssh
if [[ $cssh == "y" || $cssh == "Y" ]]; then
    sudo systemctl stop sshd # if it's running
    read -p "Which port would you like to set it on? Enter d for default. " sshport
    if [[ $sshport == "d" ]]; then
        sudo firewall-cmd --add-port 22/tcp --permanent
    else
        sudo sed -i "s/^#Port 22/Port $sshport/" /etc/ssh/sshd_config
        sudo firewall-cmd --add-port $sshport/tcp --permanent
    fi
    sudo systemctl enable sshd
    sudo systemctl restart sshd
fi

sudo firewall-cmd --reload

printf "\nRudimentary firewall setup complete. For future firewall configurations, use commands \nlike sudo firewall-cmd --add-port=<portnumber>/<protocol> --permanent, or the same with --remove-port.\n"