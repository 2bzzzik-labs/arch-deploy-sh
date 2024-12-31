#!/bin/bash

cd /home/bzik/distro/yay
makepkg -si

sudo pacman -D --asdeps $(pacman -Qqg plasma)
sudo pacman -D --asexplicit plasma-desktop breeze-gtk kde-gtk-config plasma-pa bluedevil sddm sddm-kcm plasma-nm
sudo pacman -Rsn $(pacman -Qqgdtt plasma)

yay -Sy mkinitcpio-firmware
yay -Sy  geekbench

yay -Sy ananicy-cpp cachyos-ananicy-rules irqbalance grub-customizer gamemode lib32-gamemode ttf-roboto
sudo systemctl enable --now irqbalance
sudo systemctl enable --now ananicy-cpp
sudo mkinitcpio -P
sudo grub-mkconfig -o /boot/grub/grub.cfg 

sudo tee -a /etc/fonts/local.conf << EOF
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
    <alias>
        <family>sans-serif</family>
        <prefer>
            <family>Roboto</family>
        </prefer>
    </alias>
    <alias>
        <family>serif</family>
        <prefer>
            <family>Roboto</family>
        </prefer>
    </alias>
    <alias>
        <family>monospace</family>
        <prefer>
            <family>Roboto Mono</family>
        </prefer>
    </alias>
</fontconfig>
EOF

sudo pacman -D --asdeps $(pacman -Qqg plasma)
sudo pacman -D --asexplicit plasma-desktop breeze-gtk kde-gtk-config plasma-pa bluedevil sddm sddm-kcm plasma-nm
sudo pacman -Rsn $(pacman -Qqgdtt plasma)

# WAYDROID
yay -S waydroid-git
yay -S waydroid-image-gapps


