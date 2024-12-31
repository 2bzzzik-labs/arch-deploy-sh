#!/bin/bash

echo "start post install"

############
# back log
############

#Добавить swap раздел под hipernate режим

# libreoffice
# obsidian
# yay
# 
# Thunderbird firefox (plugin translate)

pacman -Syu

# Reflector part (fastern)
pacman -Syu reflector
#reflector --protocol https Russia,Poland,China,Germany,Finland,Netherlands --age 6 --completion-percent 100 --ipv4 --fastest 15 --sort score --save /etc/pacman.d/mirrorlist
tee -a /etc/xdg/reflector/reflector.conf << EOF
--country Russia,Poland,China,Germany,Finland,Netherlands
--fastest 15
--age 6
--completion-percent 100
--ipv4
EOF

sed -e 's/--latest 10/# --latest 10/g' /etc/xdg/reflector/reflector.conf > /etc/xdg/reflector/reflector_new.conf
cp /etc/xdg/reflector/reflector_new.conf /etc/xdg/reflector/reflector.conf
rm -fr /etc/xdg/reflector/reflector_new.conf

systemctl restart reflector

# Pacman
sed -e 's/#Color/Color/g' -e 's/\#ParalleDownloads = 5/ParalleDownloads = 10\nILoveCandy/g' /etc/pacman.conf > /etc/pacman_new/conf
cp /etc/pacman_new.conf /etc/pacman.conf
rm -fr /etc/pacman_new.conf

pacman -S --needed git base-devel --noconfirm
su - bzik -c 'mkdir /home/bzik/distro'
su - bzik -c 'cd /home/bzik/distro ; git clone https://aur.archlinux.org/yay.git'

# CachyOS repos
curl https://mirror.cachyos.org/cachyos-repo.tar.xz -o cachyos-repo.tar.xz
tar xvf cachyos-repo.tar.xz && cd cachyos-repo
sh cachyos-repo.sh

tee -a /etc/pacman.conf << EOF
[cachyos]
Include = /etc/pacman.d/cachyos-mirrorlist
[cachyos-v3]
Include = /etc/pacman.d/cachyos-v3-mirrorlist
[cachyos-core-v3]
Include = /etc/pacman.d/cachyos-v3-mirrorlist
[cachyos-extra-v3]
Include = /etc/pacman.d/cachyos-v3-mirrorlist
EOF

sed -e 's/HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block filesystems fsck)/HOOKS=(systemd autodetect microcode modconf kms keyboard sd-vconsole block filesystems fsck)/g' /etc/mkinitcpio.conf > /etc/mkinitcpio_new.conf
cp /etc/mkinitcpio_new.conf /etc/mkinitcpio.conf
rm -fr /etc/mkinitcpio_new.conf
mkinitcpio -P












echo "You need to makepkg -si after End script for YAY"
sleep 5
