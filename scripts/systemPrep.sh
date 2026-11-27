#!/bin/bash

baseDir="$(dirname $(realpath $0))"

printf "### Updating system..."
sudo xbps-install -Syu
printf "### Installing X..."
sudo xbps-install -Sy xorg-server xinit libX11-devel libXft-devel libXinerama-devel glib-devel font-inconsolata-otf
sudo xbps-install -Sy xorg
printf "### Install Building tools..."
sudo xbps-install -Sy git gcc make pkg-config
printf "### Install man pages..."
sudo xbps-install -Sy man-pages-devel
printf "### Install tools for suckless surf..."
sudo xbps-install -Sy webkit2gtk-devel gcr-devel
printf "### Install tools for suckless surf to play video..."
sudo xbps-install -Sy gst-libav gst-plugins-good1
printf "### Install Multimedia..."
sudo xbps-install -Sy mpd ffmpeg mpv yt-dlp
printf "### Install Diagnostics..."
sudo xbps-install -Sy htop btop iotop
printf "### Install General Tools..."
sudo xbps-install -Sy groff sxhkd zathura-pdf-mupdf vim rsync firefox alsa-utils xz ImageMagick pass
printf "### Install e-Mail Tools..."
sudo xbps-install -Sy neomutt msmtp
printf "### Install FileSystems support..."
sudo xbps-install -Sy fuse-exfat


for sucklessProgram in $(ls $HOME/voidBuild)
do
    cd $HOME/voidBuild/$sucklessProgram
    # git checkout master
    doas make install 
    make clean
done

## Nvidia
printf "### Install nvidia..."
sudo xbps-install -Sy nvidia-opencl
