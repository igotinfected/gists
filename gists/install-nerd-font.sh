#!/usr/bin/env bash

# ensure fontconfig pkg is installed
echo "==> 📦 ensuring fontconfig package is installed..."
(dpkg-query -s fontconfig 2>/dev/null | grep -c "ok installed") || sudo apt install fontconfig -y

# TODO: allow passing font URL as argument
# download the font
	echo "⬇️ downloading the font..."
wget "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete%20Mono.ttf"

# create font directory if it doesn't exist
echo "📁 creating the font directory..."
mkdir -p $HOME/.local/share/fonts

# install the font
echo "📦 installing the font..."
mv "Fira Code Regular Nerd Font Complete Mono.ttf" $HOME/.local/share/fonts

# refresh font cache
echo "🧹 refreshing font cache..."
fc-cache -fv

echo "✅ done!"
