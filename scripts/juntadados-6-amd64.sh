#!/bin/bash

rm -rf live-default

mkdir live-default

cd live-default

lb config --architectures amd64 --debian-installer live --distribution jessie \
     --archive-areas "main contrib non-free" \
     --bootappend-live "boot=live config username=juntadados hostname=juntadados timezone=America/Sao_Paulo locales=pt_BR.UTF-8 keyboard-layouts=br quiet" \
     --linux-packages "linux-image linux-headers" \
     --firmware-chroot true --firmware-binary true \
     --apt-options "--force-yes --yes" \
     --debconf-priority critical \
     --iso-application "juntaDados GNU/Linux 6" \
     --iso-preparer "Marcelo Soares Souza" \
     --iso-publisher "Projeto de Cultura Digital juntaDados" \
     --iso-volume "juntaDados GNU/Linux 6" \
     --keyring-packages "debian-archive-keyring deb-multimedia-keyring" \
     --backports true --updates true --security true


echo deb-multimedia-keyring >> config/package-lists/desktop.list
echo desktop-base >> config/package-lists/desktop.list
echo task-lxde-desktop >> config/package-lists/desktop.list
echo task-brazilian-portuguese >> config/package-lists/desktop.list
echo task-brazilian-portuguese-desktop >> config/package-lists/desktop.list
echo virtualbox-guest-dkms >> config/package-lists/desktop.list
echo virtualbox-guest-x11 >> config/package-lists/desktop.list

echo debian-installer-launcher >> config/package-lists/desktop.list.chroot
echo debian-installer-launcher >> config/package-lists/desktop.list.binary

# echo 2mandvd ardour3 audacity audacious arduino avidemux blender brasero calibre cecilia cheese cinelerra-cv csound csound-utils darkice-full devede dvdstyler dvgrab eog evince ffmpeg file-roller flashplugin-nonfree flvmeta gcalctool gimp growisofs gthumb hydrogen icc-profiles icedtea-7-plugin inkscape jamin kde-l10n-ptbr kdenlive kdenlive-data krita ladspa-sdk libsox2 lingot lxdvdrip mjpegtools mp4v2-utils nmap oggconvert oggfwd oggvideotools ogmrip openjdk-7-jre openshot p7zip-full pitivi pulseaudio pulseaudio-utils puredata puredata-gui puredata-utils unrar rar unzip zip rosegarden scribus-ng sox swami timidity transcode transcode-utils videotrans vlc vlc-plugin-pulse winff x264 x265 zynaddsubfx fluid fluid-soundfont-gm fluid-soundfont-gs fluidsynth fluidsynth-dssi libfluidsynth1 vlc-plugin-fluidsynth lv2core lv2vocoder kino lilypond >> config/package-lists/juntadados.list

####

mkdir -p config/bootloaders

cp -rf ../live-juntadados-base/isolinux config/bootloaders/
cp -rf ../live-juntadados-base/src/rootskel-juntadados/usr/ config/includes.installer/
cp -rf ../live-juntadados-base/etc config/includes.chroot/
cp ../live-juntadados-base/sources.list config/archives/
cp ../live-juntadados-base/debs/base-files-juntadados_6_amd64.deb config/packages.chroot
cp ../live-juntadados-base/debs/base-files-juntadados_6_amd64.deb config/packages.binary

echo "d-i debian-installer/language string pt_BR" >> config/includes.installer/preseed.cfg
echo "d-i debian-installer/country string BR" >> config/includes.installer/preseed.cfg
echo "d-i debian-installer/locale select pt_BR.UTF-8" >> config/includes.installer/preseed.cfg
echo "d-i keyboard-configuration/xkb-keymap select br" >> config/includes.installer/preseed.cfg
echo "d-i localechooser/translation/warn-light boolean true" >> config/includes.installer/preseed.cfg
echo "d-i localechooser/translation/warn-severe boolean true" >> config/includes.installer/preseed.cfg
echo "d-i hw-detect/load_firmware boolean false" >> config/includes.installer/preseed.cfg
echo "d-i netcfg/get_hostname string juntadados" >> config/includes.installer/preseed.cfg
echo "d-i netcfg/get_domain string localhost" >> config/includes.installer/preseed.cfg
echo "d-i apt-setup/use_mirror boolean false" >> config/includes.installer/preseed.cfg
echo "netcfg netcfg/get_hostname string juntadados" >> config/includes.installer/preseed.cfg
echo "netcfg netcfg/get_domain string localhost" >> config/includes.installer/preseed.cfg

ln -s /home/live/cache /home/live/live-default/
