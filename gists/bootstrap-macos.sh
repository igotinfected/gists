#!/usr/bin/env bash

echo "==> 🍎 running MacOS bootstrap!"

# install basic packages
echo "==> 📦 installing basic packages..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# ensure brew install is complete before proceeding
wait
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install fish

# set fish as default shell
echo "==> 🐟 setting fish as default shell..."
sudo bash -c 'echo $(which fish) >> /etc/shells'
sudo -u $USER chsh -s $(which fish) 

echo "==> 🚀 setup complete, reboot recommended!"
