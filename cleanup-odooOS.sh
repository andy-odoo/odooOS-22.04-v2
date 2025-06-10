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

chfn -f "$employee_first_name ($employee_gram)" odoo

export DEBIAN_FRONTEND=noninteractive

#Install Gnome Software Flatpak Plugin. Flatpak repo is already intalled.

apt install -y gnome-software-plugin-flatpak

#Install dbus-x11

apt install -y dbus-x11

#Remove Canon Drivers

dpkg -P cnrdrvcups-ufr2-us
dpkg -P cnrdrvcups-ufr2-uk
dpkg -P cnrdrvcups-lipslx

#Remove app images

#Joplin

rm -rf /opt/Joplin-2.8.8.AppImage
rm -rf /usr/share/applications/joplin.desktop

#OnlyOffice

rm -rf /opt/onlyoffice/
rm -rf /usr/share/applications/onlyoffice-desktopeditors.desktop

#Ferdium

rm -rf /opt/Ferdium/
rm -rf /usr/share/applications/ferdium.desktop

#Xmind

rm -rf /opt/Xmind/
rm -rf /usr/share/applications/xmind.desktop

#Balena Etcher

rm -rf /opt/balenaEtcher/

#Uninstall deb apps

for f in `cat ./uninstall-deb-apps.txt` ; do apt remove -y $f ; done

#Remove old or invalid deb repos

rm -rf /etc/apt/sources.list.d/vscodium.list*
rm -rf /etc/apt/sources.list.d/google-chrome.*
rm -rf /etc/apt/sources.list.d/obsproject*

#Install New deb packages

#Remove Google Chrome user confuration

rm -rf /home/odoo/.config/google-chrome

#Remove Google Chrome System Defaults

rm -rf /etc/default/google-chrome

#Google Chrome

dpkg -i ./google-chrome-stable_current_amd64.deb

#Warp Terminal

dpkg -i ./warp-terminal_0.2025.05.21.08.11.stable.01_amd64.deb

#VScode

dpkg -i ./code_1.100.2-1747260578_amd64.deb

#Balena Etcher

sudo dpkg -i ./balena-etcher_2.1.2_amd64.deb

#Htop

apt install -y htop

#Neovim

apt install -y neovim

#npm

apt install -y npm

#Apt, update, upgrade and autoremove

apt update && sudo apt upgrade -y
apt apt autoremove -y

#Install flatpaks from USB Drive

flatpak remote-modify --collection-id=org.flathub.Stable flathub
for f in `cat ./flatpaks_install.txt` ; do flatpak install --sideload-repo=./flatpaks/.ostree/repo flathub -y $f ; done

#Manual Flatpak installs

#Zoom

flatpak install -y app/us.zoom.Zoom/x86_64/stable

#Spotify

flatpak install -y app/com.spotify.Client/x86_64/stable

#Update Flatpaks

flatpak update

#Set Icon Arrangement and settings

sudo -u odoo bash -c 'dconf load / < odoo-gnome-arrangement.txt'

#Add all odoo SF Printers

lpadmin -p CUSTOMERSUCCESS -E -v ipp://10.110.0.44/ipp/print -m everywhere
lpadmin -p ECOMMERCE -E -v ipp://10.110.0.45/ipp/print -m everywhere
lpadmin -p TIMESHEETS -E -v ipp://10.110.0.46/ipp/print -m everywhere

sleep 60

reboot



