#!/bin/bash

if [[ $USER != "root" ]]; then
    sudo "$0"
    exit 0
fi

#set -euo pipefail

#Set Display name to Employee Name

echo "What is the Employee's First name?" 
read employee_first_name
echo "What is the Employee's Gram?" 
read employee_gram

sudo chfn -f "$employee_first_name ($employee_gram)" odoo

export DEBIAN_FRONTEND=noninteractive

#Install Gnome Software Flatpak Plugin. Flatpak repo is already intalled.

apt install -y gnome-software-plugin-flatpak

#Install Flatseal flatpak

flatpak install -y app/com.github.tchx84.Flatseal/x86_64/stable

#Install dbus-x11

sudo apt install -y dbus-x11

#Remove Canon Drivers

sudo dpkg -P cnrdrvcups-ufr2-us
sudo dpkg -P cnrdrvcups-ufr2-uk
sudo dpkg -P cnrdrvcups-lipslx

#Remove app images

#Joplin

sudo apt remove -y codium
sudo rm -rf /etc/apt/sources.list.d/vscodium.list*

#OnlyOffice

rm -rf /opt/onlyoffice/
rm -rf /usr/share/applications/onlyoffice-desktopeditors.desktop

#Ferdium

sudo rm -rf /opt/Ferdium/
sudo rm -rf /usr/share/applications/ferdium.desktop

#Xmind

sudo rm -rf /opt/Xmind/
sudo rm -rf /usr/share/applications/xmind.desktop

#Balena Etcher

sudo rm -rf /opt/balenaEtcher/

#Spotify

sudo rm -rf /usr/bin/spotify
sudo rm -rf /usr/share/spotify/
sudo rm -rf /usr/share/applications/spotify.desktop

##Uninstall deb apps

for f in `cat ./uninstall-deb-apps.txt' ; do apt remove -y $f ; done
