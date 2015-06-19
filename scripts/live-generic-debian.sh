#!/bin/bash

rm -rf live-default

mkdir live-default

cd live-default

lb config --architectures amd64 --debian-installer live --distribution jessie \
     --archive-areas "main contrib non-free" \
     --bootappend-live "boot=live config timezone=America/Sao_Paulo locales=pt_BR.UTF-8 keyboard-layouts=br" \
     --linux-packages "linux-image linux-headers" \
     --firmware-chroot true --firmware-binary true \
     --apt-options "--force-yes --yes" \
     --debconf-priority critical \
     --backports true --updates true --security true

echo desktop-base task-gnome-desktop task-brazilian-portuguese task-brazilian-portuguese-desktop gnome-session-fallback >> config/package-lists/desktop.list
echo gpart gparted lm-sensors acpitool lsscsi lshw libc6-i386 >> config/package-lists/hw.list
echo strace ltrace telnet htop iotop libncurses5-dev mysql-client postgresql-client sqlite3 nmap tcpdump openssh-client >> config/package-lists/misc.list
echo net-tools gimp inkscape eog gthumb evince rar unrar zip unzip p7zip-full bzip2 gzip icedtea-7-plugin >> config/package-lists/misc.list
echo openjdk-7-jre brasero vlc libav-tools audacious gcalctool bumblebee git git-svn subversion >> config/package-lists/misc.list
echo wireshark xsane hdparm gpm pxz lbzip2 build-essential libncurses5-dev ruby-full python3 python3-pip gedit file-roller >> config/package-lists/misc.list
echo virtualbox-guest-dkms virtualbox-guest-x11 >> config/package-lists/virtualbox.list
echo grub2 >> config/package-lists/grub.list

echo debian-installer-launcher >> config/package-lists/desktop.list.chroot
echo debian-installer-launcher >> config/package-lists/desktop.list.binary

cp ../base/postgresql.key config/archives/
cp ../base/sources.list config/archives/

echo "d-i debian-installer/language string pt_BR" >> config/includes.installer/preseed.cfg
echo "d-i debian-installer/country string BR" >> config/includes.installer/preseed.cfg
echo "d-i debian-installer/locale select pt_BR.UTF-8" >> config/includes.installer/preseed.cfg
echo "d-i keyboard-configuration/xkb-keymap select br" >> config/includes.installer/preseed.cfg
echo "d-i localechooser/translation/warn-light boolean true" >> config/includes.installer/preseed.cfg
echo "d-i localechooser/translation/warn-severe boolean true" >> config/includes.installer/preseed.cfg
echo "d-i hw-detect/load_firmware boolean false" >> config/includes.installer/preseed.cfg
echo "d-i apt-setup/use_mirror boolean false" >> config/includes.installer/preseed.cfg
echo "d-i netcfg/get_hostname string live" >> config/includes.installer/preseed.cfg
echo "d-i netcfg/get_domain string localhost" >> config/includes.installer/preseed.cfg
echo "netcfg netcfg/get_hostname string live" >> config/includes.installer/preseed.cfg
echo "netcfg netcfg/get_domain string localhost" >> config/includes.installer/preseed.cfg

ln -s /home/live/cache /home/lbb/live-default/
