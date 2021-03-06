#! /bin/bash
# Awesome Init Script
# 2015.12.20 Created By YWJamesLin

# Fetch Source
git clone https://github.com/YWJamesLin/awesome_config

# Global Init
sudo mkdir /usr/share/awesome/themes/customTheme
sudo cp -a awesome_config/theme.lua /usr/share/awesome/themes/customTheme/
sudo mkdir /usr/share/awesome/themes/customTheme/wallpapers
sudo mkdir /usr/share/awesome/themes/customTheme/wallpapers_vert

# User Init
mkdir -p ~/.config/awesome
cp awesome_config/awesome/* ~/.config/awesome
