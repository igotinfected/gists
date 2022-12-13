#!/usr/bin/env bash

# detect OS (based on https://github.com/microsoft/WSL/issues/4071#issuecomment-1223393940)
echo "==> 🔍 determining OS..."
unameOut=$(uname -a)
case "${unameOut}" in
    *Microsoft*)     OS="WSL";;
    *microsoft*)     OS="WSL2";;
    Linux*)     OS="Linux";;
    Darwin*)    OS="Mac";;
    CYGWIN*)    OS="Cygwin";;
    MINGW*)     OS="Windows";;
    *Msys)     OS="Windows";;
    *)          OS="UNKNOWN:${unameOut}"
esac
echo "==> 💡 OS determined as ${OS}!"

# install basic packages
echo "==> 📦 installing basic packages..."
sudo apt install -y \
	apt-transport-https \
	build-essential \
	ca-certificates \
	software-properties-common \
	bat \
	curl \
	fish \
	gnupg \
	pass \
	git \
	openssh-server \
	openvpn \
	vim \
	exa

# set fish as default shell
echo "==> 🐟 setting fish as default shell..."
chsh -s /usr/bin/fish

# install nerd font
echo "==> 💅 installing nerd font..."
curl -sS https://gist.githubusercontent.com/igotinfected/b86359da8e64fd3cfd1fa11fbcbb36ba/raw/install-nerd-font.sh | sh

# install starship
echo "==> 🌌 installing starship..."
curl -sS https://starship.rs/install.sh | sh


# configure windows settings (based on https://github.com/Alex-D/dotfiles#setup-windows-terminal)
echo "==> ⚙️ configuring windows specific settings (windows terminal, pwsh profile, ...)"

windowsUserProfile=/mnt/c/Users/$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')
if [[ ${OS} == "WSL" ]] || [[ ${OS} == "WSL2" ]]; then
    # copy windows terminal settings
    cp .config/windows-terminal/settings.json ${windowsUserProfile}/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json
    
    # create pwsh folder and copy profile
    mkdir -p ${windowsUserProfile}/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1
    cp .config/pwsh/pwsh-profile.ps1 ${windowsUserProfile}/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1
    # copy starship config
    mkdir -p ${windowsUserProfile}/.config
    cp .config/starship/config.toml ${windowsUserProfile}/.config/starship.toml
fi

# cleanup
echo "==> 🧹 cleanup..."
sudo apt install -y -f
sudo apt autoremove -y
sudo apt clean

echo "==> 🚀 setup complete, reboot recommended!"
