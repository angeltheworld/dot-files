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
