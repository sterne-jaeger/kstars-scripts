#!/bin/sh
eval `grep "^ID=" /etc/os-release`

if (echo $ID | grep -q "opensuse"); then
    sudo zypper install -y xrdp emacs qt6-creator
else
    sudo apt install -y xrdp emacs qtcreator
fi
