#!/bin/bash

echo "--------------------------------------------------------------------------"
echo -e "\ninstalling dependencies: \n"

# Installing dependencies
sudo apt-get update && sudo apt-get install Xorg consolekit vim curl exuberant-ctags git cmake vim-nox clang-3.5 python-dev libboost-dev python-py++ verse cowsay uuid-runtime silversearcher-ag i3 i3lock i3status pm-utils keychain ssh mutt calcurse tidy xclip autotools-dev -y
