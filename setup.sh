#!/bin/bash
# Script to setup a sway environment

# Install packages listed in 'packages.txt'
# And ignore comments
echo 'Installing packages...'
sudo pacman -S --noconfirm - < <(grep -v '^#' packages.txt)
echo 'Packages ready :)'

# Copy config files
echo 'Copying configuration files to home directory...'
mkdir $HOME/.config -p

# Get subdirectories and copy
subdir=$(ls -l | grep '^d' | cut -d ' ' -f 9)
cp -r $subdir $HOME/.config
echo 'Configuration files ready :)'

# Wallpapers
echo 'Installing wallpapers...'
mkdir $HOME/.config/wallpapers
while IFS= read -r line; do
        url=$(echo $line | cut -d ' ' -f 1)
        name=$(echo $line | cut -d ' ' -f 2)
        wget $url -O $HOME/.config/wallpapers/$name
done < wallpapers.txt
echo 'Wallpapers ready :)'
