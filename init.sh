#! /bin/bash
# Awesome Init Script
# 2015.12.20 Created By YWJamesLin

# Fetch Source
git clone https://github.com/YWJamesLin/awesome_config
git clone https://github.com/YWJamesLin/awesome_battery_widget

# Global Init
sudo mkdir /usr/share/awesome/themes/customTheme
cp -a awesome_config/theme.lua /usr/share/awesome/themes/customTheme/
sudo mkdir /usr/share/awesome/themes/customTheme/wallpapers

# User Init
mkdir -p ~/.config/awesome
cp awesome_config/awesome/* ~/.config/awesome
cp awesome_battery_widget/battery.lua ~/.config/awesome
